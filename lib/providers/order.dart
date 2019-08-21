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
      loadedOrders.add(
        OrderItem(
          id: id,
          amount: orderItem['amount'],
          date: DateTime.parse(orderItem['date']),
          products: (orderItem['products'] as List<dynamic>)
              .map((cartItem) => CartItem(
                    id: cartItem['id'],
                    title: cartItem['title'],
                    price: cartItem['price'],
                    quantity: cartItem['quantity'],
                  ))
              .toList(),
        ),
      );
      _orders = loadedOrders;
    });
  }

  Future<void> addOrder(double amount, List<CartItem> products) async {
    const url = 'https://flutter-shop-28335.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': amount,
            'products': products
                .map((cartItem) => {
                      'id': cartItem.id,
                      'title': cartItem.title,
                      'quantity': cartItem.quantity,
                      'price': cartItem.price,
                      // 'total': product.price * product.quantity,
                    })
                .toList(),
            'date': timestamp.toIso8601String(),
          }));
      // implement add new order
      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: amount,
            products: products,
            date: timestamp,
          ));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
