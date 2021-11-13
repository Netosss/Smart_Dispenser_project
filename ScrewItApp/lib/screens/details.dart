import 'package:flutter/material.dart';
import '../screw_item.dart';
import '../menu.dart';

class DetailPage extends StatelessWidget {

  final Elmnt element;
  DetailPage(String id) : element = Menu.getElementById(id);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87,),
          onPressed: (){
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: new Center(
        child: new Hero(
          tag: 'icon-${element.id}',
          child: new Image(
            image: new AssetImage(element.image),
            height: 150.0,
            width: 150.0,
          ),
        ),
      ),
    );
  }
}
