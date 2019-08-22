import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
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

  Future<void> toogleFavorite(String tokenId, String userId) async {
    final url =
        'https://flutter-shop-28335.firebaseio.com/usersFavorite/$userId/$id.json?auth=$tokenId';
    final oldValue = isFavorite;
    _setFavorite(!oldValue);
    Dio dio = Dio();

    try {
      final response = await dio.put(url, data: isFavorite);
    } catch (error) {
      _setFavorite(oldValue);
      print(error.response.data.toString());
    }
  }
}
