
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu/menu.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../widgets/costume_dialog.dart';
import '../widgets/tts_platform.dart';



bool IsSendable(){
  return Menu.menu[0].cart_quantity > 0 || Menu.menu[1].cart_quantity > 0;
}
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
                tooltip: 'cancel order',
                icon: new Icon(
                   MaterialIcons.cancel, size: 40.0,
                    color: Colors.black87),
                onPressed: () {
                  if(IsSendable()){
                    speak("order has been canceled");
                    CancelOrder();
                    showDialog(barrierDismissible: false, context: context, builder: (context) => WillPopScope(
                        onWillPop: () async => false, // <-- Prevents dialog dismiss on press of back button.
                        child:CustomDialog(
                          title: "Order has been canceled!",
                          description: "",
                          imagePath: 'assets/images/delete.gif',
                          buttonText: 'great!',
                          IsError: true,
                        )));
                  }
                  else{
                    speak("order is already empty");
                    showDialog(barrierDismissible: false,context: context, builder: (context) => CustomDialog(
                      title: "order is empty",
                      description: "",
                      imagePath: 'assets/images/delete.gif',
                      buttonText: 'cool',
                      IsError: true,
                    )
                    );
                  }
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
              if(IsSendable()){
                speak("order has been sent, the order is: ${Menu.menu[0].cart_quantity} from type ${Menu.menu[0].name}, and ${Menu.menu[1].cart_quantity} from type ${Menu.menu[1].name}");
                sendMessage();
                showDialog(barrierDismissible: false, context: context, builder: (context) => WillPopScope(
                    onWillPop: () async => false, // <-- Prevents dialog dismiss on press of back button.
                      child:CustomDialog(
                      title: "Sent!",
                      description: "the order has been sent to the machine, please wait",
                      imagePath: 'assets/images/run.gif',
                      buttonText: 'please wait..',
                      IsError: false,
                      )));
                      }
              else{
                speak("order is empty");
                showDialog(barrierDismissible: false,context: context, builder: (context) => CustomDialog(
                  title: "Oops",
                  description: "order is empty, please choose items",
                  imagePath: 'assets/images/error.gif',
                  buttonText: 'got it',
                  IsError: true,
                )
                );
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
      Menu.menu[i] = Menu.menu[i].copyWith(cart_quantity: 0);
    }
    elementList.update({ 'done_updating': true});  }

    void CancelOrder(){
      for(int i = 0; i < Menu.menu.length; i++){
        Menu.menu[i] = Menu.menu[i].copyWith(cart_quantity: 0);
      }
    }
}

