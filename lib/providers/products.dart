import './product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Product> loadedProducts = [
  Product(
    id: 'p1',
    title: 'Red Shirt',
    description: """
    

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean quis volutpat quam. Morbi ultrices sed eros vel sodales. Cras tempor elit vel ornare pulvinar. Cras tortor risus, posuere et bibendum in, imperdiet non justo. Praesent tincidunt nisl enim, sed commodo sapien malesuada in. Etiam semper varius metus at feugiat. Nullam quis tellus vel erat rhoncus ultrices. In erat est, feugiat vitae lorem at, feugiat eleifend elit. Sed sed interdum sapien, ut elementum nisl.

Phasellus ut erat sit amet ante elementum lacinia. Interdum et malesuada fames ac ante ipsum primis in faucibus. In facilisis bibendum felis, eget semper neque condimentum ut. Mauris molestie porttitor tellus, eu laoreet ligula laoreet at. Pellentesque eget fringilla diam. Cras pellentesque luctus est, eu vestibulum dui venenatis at. Donec fringilla vehicula tempus. Phasellus consequat consequat aliquet. In euismod luctus sapien sit amet consectetur. Curabitur eleifend finibus massa, a volutpat massa porttitor eget. Nam pellentesque ex a turpis ornare cursus. Maecenas interdum dui vel urna feugiat sagittis.

Quisque condimentum et metus et imperdiet. Ut gravida, arcu in egestas faucibus, augue diam tincidunt nisl, ac dignissim nunc ante sed nibh. Morbi ut felis sagittis, auctor odio id, interdum erat. Aliquam luctus massa nec odio vestibulum suscipit. Maecenas non lorem ac eros ultricies iaculis. Integer lacinia, lectus non rhoncus tincidunt, magna libero malesuada dolor, eu molestie felis mi vitae sem. Fusce bibendum purus consectetur vestibulum auctor. Nullam sagittis sodales lorem. Ut scelerisque lacinia eleifend. Aenean ac lorem egestas, rhoncus massa non, elementum risus. Vestibulum eleifend porttitor nisl. Nunc rhoncus nisl metus, ac ullamcorper risus ultrices nec. Ut gravida, mauris quis aliquet pellentesque, quam nunc egestas ipsum, nec egestas enim lacus in erat. Quisque tristique aliquet felis, ut dignissim odio ultricies eu. Mauris risus libero, commodo et feugiat ut, tempor eget erat. Quisque pharetra consequat mollis.

Phasellus suscipit eleifend tellus, id fermentum leo rutrum in. Sed pretium commodo libero euismod fermentum. Suspendisse tincidunt lobortis nunc, a tincidunt dui. Proin congue magna sed arcu gravida, et imperdiet magna tincidunt. Fusce commodo placerat maximus. Morbi vulputate nulla at eros vulputate lobortis. Sed eget mi vehicula, viverra leo et, tincidunt purus.

Pellentesque interdum ex sed magna efficitur, sed tempus magna blandit. Sed dapibus, enim sit amet varius vehicula, tortor diam ultricies mi, et facilisis eros enim vitae nisl. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis ut malesuada felis, ut auctor dui. Etiam at volutpat est. Sed viverra tellus sed varius convallis. Donec scelerisque nisi nunc, eget faucibus diam bibendum quis. Aenean quis elit vel mauris maximus commodo. Proin cursus gravida ipsum, vel vehicula justo ultrices ut.

Suspendisse orci erat, venenatis non eros ut, malesuada aliquam ipsum. In arcu ex, vestibulum sed pretium sit amet, euismod ut ex. Phasellus pellentesque pretium quam sed porttitor. In hac habitasse platea dictumst. Cras nec egestas nibh. Sed luctus, sapien a condimentum maximus, sem odio consectetur tortor, in facilisis risus mi non dolor. In ut est nec orci feugiat luctus sed id ex. Pellentesque pulvinar quis mi ac euismod. Etiam convallis odio eu molestie. 
    """,
    price: 29.99,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
  Product(
    id: 'p2',
    title: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  ),
  Product(
    id: 'p3',
    title: 'Yellow Scarf',
    description: """
    

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean quis volutpat quam. Morbi ultrices sed eros vel sodales. Cras tempor elit vel ornare pulvinar. Cras tortor risus, posuere et bibendum in, imperdiet non justo. Praesent tincidunt nisl enim, sed commodo sapien malesuada in. Etiam semper varius metus at feugiat. Nullam quis tellus vel erat rhoncus ultrices. In erat est, feugiat vitae lorem at, feugiat eleifend elit. Sed sed interdum sapien, ut elementum nisl.

Phasellus ut erat sit amet ante elementum lacinia. Interdum et malesuada fames ac ante ipsum primis in faucibus. In facilisis bibendum felis, eget semper neque condimentum ut. Mauris molestie porttitor tellus, eu laoreet ligula laoreet at. Pellentesque eget fringilla diam. Cras pellentesque luctus est, eu vestibulum dui venenatis at. Donec fringilla vehicula tempus. Phasellus consequat consequat aliquet. In euismod luctus sapien sit amet consectetur. Curabitur eleifend finibus massa, a volutpat massa porttitor eget. Nam pellentesque ex a turpis ornare cursus. Maecenas interdum dui vel urna feugiat sagittis.

Quisque condimentum et metus et imperdiet. Ut gravida, arcu in egestas faucibus, augue diam tincidunt nisl, ac dignissim nunc ante sed nibh. Morbi ut felis sagittis, auctor odio id, interdum erat. Aliquam luctus massa nec odio vestibulum suscipit. Maecenas non lorem ac eros ultricies iaculis. Integer lacinia, lectus non rhoncus tincidunt, magna libero malesuada dolor, eu molestie felis mi vitae sem. Fusce bibendum purus consectetur vestibulum auctor. Nullam sagittis sodales lorem. Ut scelerisque lacinia eleifend. Aenean ac lorem egestas, rhoncus massa non, elementum risus. Vestibulum eleifend porttitor nisl. Nunc rhoncus nisl metus, ac ullamcorper risus ultrices nec. Ut gravida, mauris quis aliquet pellentesque, quam nunc egestas ipsum, nec egestas enim lacus in erat. Quisque tristique aliquet felis, ut dignissim odio ultricies eu. Mauris risus libero, commodo et feugiat ut, tempor eget erat. Quisque pharetra consequat mollis.

Phasellus suscipit eleifend tellus, id fermentum leo rutrum in. Sed pretium commodo libero euismod fermentum. Suspendisse tincidunt lobortis nunc, a tincidunt dui. Proin congue magna sed arcu gravida, et imperdiet magna tincidunt. Fusce commodo placerat maximus. Morbi vulputate nulla at eros vulputate lobortis. Sed eget mi vehicula, viverra leo et, tincidunt purus.

Pellentesque interdum ex sed magna efficitur, sed tempus magna blandit. Sed dapibus, enim sit amet varius vehicula, tortor diam ultricies mi, et facilisis eros enim vitae nisl. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis ut malesuada felis, ut auctor dui. Etiam at volutpat est. Sed viverra tellus sed varius convallis. Donec scelerisque nisi nunc, eget faucibus diam bibendum quis. Aenean quis elit vel mauris maximus commodo. Proin cursus gravida ipsum, vel vehicula justo ultrices ut.

Suspendisse orci erat, venenatis non eros ut, malesuada aliquam ipsum. In arcu ex, vestibulum sed pretium sit amet, euismod ut ex. Phasellus pellentesque pretium quam sed porttitor. In hac habitasse platea dictumst. Cras nec egestas nibh. Sed luctus, sapien a condimentum maximus, sem odio consectetur tortor, in facilisis risus mi non dolor. In ut est nec orci feugiat luctus sed id ex. Pellentesque pulvinar quis mi ac euismod. Etiam convallis odio eu molestie. 
    """,
    price: 19.99,
    imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  ),
  Product(
    id: 'p4',
    title: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  ),
];

class Products with ChangeNotifier {
  List<Product> _items = loadedProducts;

  List<Product> get items {
    return [..._items];
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://flutter-shop-28335.firebaseio.com/products';
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

  void updateProduct(String id, Product product) {
    var prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = product;
    } else {
      print('Cannot find the product id');
    }
    notifyListeners();
  }

  void removeProduct(String id) {
    var prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items.removeAt(prodIndex);
    } else {
      print('Cannot find the product id');
    }
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite == true).toList();
  }
}
