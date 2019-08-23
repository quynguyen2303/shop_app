import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

import '../providers/products.dart';

import '../screens/user_edit_screen.dart';

class UserProductScreen extends StatelessWidget {
  static final routeName = '/user_product';

  Future<void> _refeshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context); // cannot use because infinite loop
    // with FutureBuilder
    print('building...');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(UserEditScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: _refeshProducts(context),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                // Handling errors later
                return AlertDialog();
              } else {
                // print('Pass connection');
                return RefreshIndicator(
                  onRefresh: () => _refeshProducts(context),
                  child: Consumer<Products>(
                    builder: (context, productsData, _ ) => ListView.builder(
                      itemCount: productsData.items.length,
                      itemBuilder: (context, int) => UserProductItem(
                        productsData.items[int].id,
                        productsData.items[int].title,
                        productsData.items[int].imageUrl,
                      ),
                    ),
                  ),
                );
              }
            }
          }),
    );
  }
}
