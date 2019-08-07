import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Product(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
        ),
        body: ProductsGrid(),
      ),
    );
  }
}
