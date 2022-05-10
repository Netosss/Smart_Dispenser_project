
class Elmnt {

  final String name;
  final String image;
  final String id;
  final int quantity;
  final int cart_quantity;

  const Elmnt({
    this.id,
    this.image,
    this.name,
    this.quantity: 0,
    this.cart_quantity: 0,
  }): assert(quantity != null && quantity >= 0);

  Elmnt copyWith({String id, String image, String name, String price, int quantity, int cart_quantity}){
    return new Elmnt(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      cart_quantity: cart_quantity ?? this.cart_quantity,

    );
  }
}