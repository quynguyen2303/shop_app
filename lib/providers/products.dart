import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://flutter-shop-28335.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedResponse =
          json.decode(response.body) as Map<String, dynamic>;
      // print(extractedResponse);
      final List<Product> loadedProducts = [];
      extractedResponse.forEach((id, prod) {
        final newProduct = Product(
          title: prod['title'],
          description: prod['description'],
          imageUrl: prod['imageUrl'],
          price: prod['price'],
          isFavorite: prod['isFavorite'],
          id: id,
        );
        // print(newProduct);
        loadedProducts.add(newProduct);
        _items = loadedProducts;
      });
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://flutter-shop-28335.firebaseio.com/products.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));

      final newProduct = Product(
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    var prodIndex = _items.indexWhere((prod) => prod.id == id);
    final url = 'https://flutter-shop-28335.firebaseio.com/products/$id.json';

    if (prodIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));
      _items[prodIndex] = product;
    } else {
      print('Cannot find the product id');
    }
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    var prodIndex = _items.indexWhere((prod) => prod.id == id);
    final url = 'https://flutter-shop-28335.firebaseio.com/products/$id.json';

    final Product existingItem = _items.elementAt(prodIndex);
    _items.removeAt(prodIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(prodIndex, existingItem);
      notifyListeners();
      throw HttpException('Cannot delete the product.');
    }
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite == true).toList();
  }
}
