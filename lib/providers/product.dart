import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

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
      await dio.put(url, data: isFavorite);
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.data);
        print(error.response.headers);
        print(error.response.request);
      } else {
        _setFavorite(oldValue);
        print(error.message);
        print(error.request);

      }
    }
  }
}
