import 'package:flutter/foundation.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    const url = 'https://flutter-shop-28335.firebaseio.com/orders.json';
    List<OrderItem> loadedOrders = [];
    final response = await http.get(url);
    final extractedOrders = json.decode(response.body) as Map<String, dynamic>;
    // print(response.body);
    extractedOrders.forEach((id, orderItem) {
      final newOrderItem = OrderItem(
        id: id,
        amount: orderItem['amount'],
        date: DateTime.now(),
        products: orderItem['products']
            .map((prod) => CartItem(
                  id: prod['id'],
                  title: prod['title'],
                  price: prod['price'],
                  quantity: prod['quantity'],
                ))
            .toList(),
      );
      loadedOrders.add(newOrderItem);
      _orders = loadedOrders;
    });
  }

  Future<void> addOrder(double amount, List<CartItem> products) async {
    const url = 'https://flutter-shop-28335.firebaseio.com/orders.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': amount,
            'products': products
                .map((product) => {
                      'id': product.id,
                      'title': product.title,
                      'quantity': product.quantity,
                      'price': product.price,
                      'total': product.price * product.quantity,
                    })
                .toList(),
            'date': DateTime.now().toString(),
          }));

      // implement add new order
      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: amount,
            products: products,
            date: DateTime.now(),
          ));
      notifyListeners();
    } catch (error) {
      print('Failed Order');
      throw error;
    }
  }
}
