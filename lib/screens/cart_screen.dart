import 'package:flutter/material.dart';
import '../providers/cart.dart' show Cart;
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';
import '../providers/order.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  // bool _isOrdering = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.itemsTotal}'),
                    labelStyle: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('ORDER NOW'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      // _isOrdering = true;
                      final currentOrder =
                          Provider.of<Orders>(context, listen: false);
                      try {
                        await currentOrder.addOrder(
                          cart.itemsTotal,
                          cart.items.values.toList(),
                        );
                        print('Passed');
                        cart.clear();
                      } catch (error) {
                        print(error);
                        print('Failed');
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Cannot add order."),
                        ));
                      }
                      // Navigator.of(context).pushNamed(OrderScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 8.0,
              ),
              itemCount: cart.itemsCount,
              itemBuilder: (context, int) => CartItem(
                cart.items.values.toList()[int].id,
                cart.items.keys.toList()[int],
                cart.items.values.toList()[int].price,
                cart.items.values.toList()[int].quantity,
                cart.items.values.toList()[int].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
