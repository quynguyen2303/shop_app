import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

import '../providers/products.dart';

import '../screens/user_edit_screen.dart';



class UserProductScreen extends StatelessWidget {
  static final routeName = '/user_product';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(UserEditScreen.routeName);
          },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: productsData.items.length,
        itemBuilder: (context, int) => UserProductItem(
          productsData.items[int].id,
          productsData.items[int].title,
          productsData.items[int].imageUrl,
        ),
      )
      
    );
  }
}