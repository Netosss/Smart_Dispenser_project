import './screw_item.dart';

class Menu {
  static List<Elmnt> menu = [
    Elmnt(
        id: "1",
        image: "assets/images/screw1.png",
        name: "Screw 1X4 phillips"),
    Elmnt(
        id: "2",
        image: "assets/images/screw2.png",
        name: "Screw 2X4"),
  ];

  static Elmnt getElementById(id) {
    return menu.where((p) => p.id == id).first;
  }
}
