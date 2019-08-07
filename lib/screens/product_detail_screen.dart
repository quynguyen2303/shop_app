import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail_screen';

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<Products>(
      context,
      listen: false
    ).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
