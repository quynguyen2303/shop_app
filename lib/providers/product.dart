import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void _setFavorite(value) {
    isFavorite = value;
    notifyListeners();
  }

  Future<void> toogleFavorite() async {
    final url = 'https://flutter-shop-28335.firebaseio.com/products/$id.json';
    final oldValue = isFavorite;
    _setFavorite(!oldValue);
    final response =
        await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
    if (response.statusCode >= 400) {
      _setFavorite(oldValue);
      throw HttpException('Cannot add favorite product.');
    }
  }
}
