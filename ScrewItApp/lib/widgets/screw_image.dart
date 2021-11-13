import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../screw_item.dart';
import 'dart:math' as math;

import '../routes.dart';

class ScrewImage extends StatelessWidget {
  ScrewImage({this.element});
  final Elmnt element;

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: FractionalOffset.topCenter,
      child:  new GestureDetector(
        behavior: HitTestBehavior.opaque,
//        onTap: () =>
//            Routes.navigateTo(
//              context,
//              '/detail/${food.id}',
//            ),
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