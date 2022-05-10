import './screw_item.dart';

class Menu {
  static List<Elmnt> menu = [
    Elmnt(
        id: "1",
        image: "assets/images/screw1.png",
        name: "1X4 Screw"),
    Elmnt(
        id: "2",
        image: "assets/images/screw2.png",
        name: "1X2 Screw"),
  ];

  static Elmnt getElementById(id) {
    return menu.where((p) => p.id == id).first;
  }
}
