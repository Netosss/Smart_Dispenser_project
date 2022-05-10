import 'package:flutter/material.dart';
import '../screw_item.dart';
import 'dart:math' as math;

class ItemCard extends StatelessWidget {
  const ItemCard({this.elmnt, this.increment, this.decrement});

  final Elmnt elmnt;
  final VoidCallback increment;
  final VoidCallback decrement;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: new Card(
          elevation: 0.0,
          child: new Container(
            height: math.min(300.0, MediaQuery.of(context).size.height),
            child: new Container(
              margin: const EdgeInsets.only(top: 50.0, bottom: 30.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text(elmnt.name,
                      style: const TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Dosis')),
                  new DecoratedBox(
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: new ClipRRect(
                      borderRadius: new BorderRadius.circular(50.0),
                      child: new MaterialButton(
                        minWidth: 70.0,
                        onPressed: null,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(Icons.remove),
                          onPressed: elmnt.quantity == 0 ? null : decrement,
                        ),
                        new Container(
                          decoration: new BoxDecoration(
                            border: new Border.all(
                              color: Colors.grey[700],
                              width: 0.5,
                            ),
                          ),
                          child: new SizedBox(
                            width: 70.0,
                            height: 45.0,
                            child: new Center(
                                child: new Text('${elmnt.quantity}',
                                    style: Theme.of(context).textTheme.bodyText1,
                                    textAlign: TextAlign.center)),
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.add),
                          onPressed: increment,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
