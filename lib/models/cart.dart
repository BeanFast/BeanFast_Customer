class Cart {
  String sessionDetailId;
  String profileId;
  Set<CartItem> listCartItem = {};

  Cart({
    required this.sessionDetailId,
    required this.profileId,
  });
}

class CartItem {
  String menuDetailId;
  int quantity = 1;
  double price;
  double pricesOnMenu;
  String? note = '';

  CartItem({
    required this.menuDetailId,
    required this.quantity,
    required this.price,
    required this.pricesOnMenu,
  });

  void increase() {
    quantity++;
  }

  void decrease() {
    if (quantity >= 1) {
      quantity--;
    }
  }

  @override
  String toString() {
    return 'Food(menuDetailId: $menuDetailId, quantity: $quantity, price: $price, pricesOnMenu: $pricesOnMenu)';
  }
}
