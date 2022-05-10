import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../menu.dart';
import '../widgets/tts_platform.dart';

bool IsSendable(){
  return Menu.menu[0].cart_quantity > 0 || Menu.menu[1].cart_quantity > 0;
}

class CustomDialog extends StatefulWidget {
  final String title, description, buttonText, imagePath;
  final Image image;
  final bool IsError;
  CustomDialog({this.title, this.description, this.buttonText, this.imagePath, this.image, this.IsError});
  @override
  State<CustomDialog> createState() => _CustomDialog(
      title: this.title,
      description: this.description,
      buttonText: this.buttonText,
      imagePath: this.imagePath,
      image: this.image,
      IsError: this.IsError
  );
}

class _CustomDialog extends State<CustomDialog> {
  String title, description, buttonText, imagePath;
  Image image;
  bool IsError;
  bool IsClickable = false;
  final _database = FirebaseDatabase.instance.reference();
  _CustomDialog({this.title, this.description, this.buttonText, this.imagePath, this.image, this.IsError});

  void initState(){
    super.initState();
    _activateListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, this.imagePath, this.IsError),

    );
  }

  void _activateListeners(){
    _database.child("finished").onValue.listen((event) {
      final bool IsFinished = event.snapshot.value;
      if (IsFinished) {
        String message = "order is ready, please collect your screws";
        speak(message);
        setState(() {
          IsClickable = true;
          title = 'done!';
          description = message;
          imagePath = 'assets/images/verified1.gif';
          buttonText = 'awesome!';
          _database.update({"finished": false});
        });
      }
    });
  }

  dialogContent(BuildContext context, String imagePath, bool IsError){
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
                  child: Opacity(
                    opacity: (!IsError && !IsClickable ) ? 0.2 : 1.0,
                    child: TextButton(
                      onPressed: (){
                        if(IsClickable || IsError) {
                          Navigator.pop(context);
                        }
                        else null;
                      },
                      child: Text(this.buttonText),
                    ),
                  )
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