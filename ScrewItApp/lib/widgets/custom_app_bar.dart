
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu/menu.dart';
import '../screens/pager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_icons/flutter_icons.dart';


class CustomAppBar extends StatelessWidget {
  final database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(
        top: MediaQuery
            .of(context)
            .padding
            .top,
        right: 5.0,
      ),
      child: new Row(
        children: [
          new Expanded(flex: 3, child: new Row(
            children: <Widget>[
              new IconButton(
                tooltip: 'Menu Icon',
                icon: new Icon(
                    const IconData(
                        0xe802,
                        fontFamily: 'fontello'), size: 18.0,
                    color: Colors.black87),
                onPressed: () {
                  print('heyy');
                },
              ),
              new Expanded(
                child: new Text(
                    'SCREW MENU',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 21.0,
                        fontFamily: 'Dosis',
                        fontWeight: FontWeight.w600
                    )),
              ),
            ],
          ),
          ),
          new IconButton(
            tooltip: 'Send order!',
            icon: Icon(FontAwesome.paper_plane_o,
                color: Colors.black,size: 30,),
            onPressed: () {
              if(Menu.menu[0].cart_quantity > 0 || Menu.menu[1].cart_quantity > 0){
                sendMessage();
                showDialog(context: context, builder: (context) => CustomDialog(
                  title: "Success",
                  description: "the order been sent to the machine, please wait till the buzz",
                  imagePath: 'assets/images/giphy.gif',
                ));
              }
              else{
                showDialog(context: context, builder: (context) => CustomDialog(
                    title: "Oops",
                    description: "order is empty, please choose items",
                  imagePath: 'assets/images/fail.gif',
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  void sendMessage(){
    final elementList = database.child('/elements');
    for(int i = 0; i < Menu.menu.length; i++){
      elementList.child('/element${i}').update({
        'quantity': Menu.menu[i].cart_quantity,
      });
      print('got here');
      Menu.menu[i] = Menu.menu[i].copyWith(cart_quantity: 0);
    }
    elementList.update({ 'done_updating': true});  }
}



class CustomDialog extends StatelessWidget {
  final String title, description, buttonText, imagePath;
  final Image image;

  CustomDialog({this.title, this.description, this.buttonText, this.imagePath, this.image});
  @override
Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, this.imagePath),

    );
  }
dialogContent(BuildContext context, String imagePath){
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(
              top: 100,
              bottom: 16,
              left: 16,
              right: 16
            ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),

              )
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(description, style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("awesome"),
                ),
              )
              ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 50,
            backgroundImage: AssetImage(imagePath),
          ),
        )
      ],
    );
  }
}
