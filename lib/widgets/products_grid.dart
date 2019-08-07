import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      itemBuilder: (context, int) => ProductItem(products[int].id,
          products[int].title, products[int].imageUrl),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 3 / 2,
      ),
    );
  }
}