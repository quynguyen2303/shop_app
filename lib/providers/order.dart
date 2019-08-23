import 'package:flutter/foundation.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
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

  final String tokenId;
  final String userId;
  Dio dio = Dio();

  Orders(this.tokenId, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutter-shop-28335.firebaseio.com/orders/$userId.json?auth=$tokenId';
    List<OrderItem> loadedOrders = [];

    try {
      final response = await dio.get(url);
      // print(response.body);
      if (response.data == null) {
        return;
      }
      response.data.forEach(
        (id, orderItem) {
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
        },
      );
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    }
    _orders = loadedOrders;
  }

  Future<void> addOrder(double amount, List<CartItem> products) async {
    final url =
        'https://flutter-shop-28335.firebaseio.com/orders/$userId.json?auth=$tokenId';
    final timestamp = DateTime.now();

    try {
      final response = await dio.post(
        url,
        data: {
          'creatorId': userId,
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
        },
      );
      // implement add new order
      _orders.insert(
        0,
        OrderItem(
          id: response.data['name'],
          amount: amount,
          products: products,
          date: timestamp,
        ),
      );
      notifyListeners();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    }
  }
}
