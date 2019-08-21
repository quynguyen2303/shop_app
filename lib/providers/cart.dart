import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addCartItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      // item already exists in cart
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                title: existingCartItem.title,
                price: existingCartItem.price,
                id: existingCartItem.id,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }

  double get itemsTotal {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    } else if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) {
          return CartItem(
            id: existingCartItem.id,
            quantity: existingCartItem.quantity - 1,
            title: existingCartItem.title,
            price: existingCartItem.price,
          );
        },
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
