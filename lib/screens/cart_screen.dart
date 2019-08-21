import 'package:flutter/material.dart';
import '../providers/cart.dart' show Cart;
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';
import '../providers/order.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
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
                  OrderButton(cart: cart),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      textColor: Theme.of(context).primaryColor,
      onPressed: (widget.cart.itemsCount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              final currentOrder = Provider.of<Orders>(context, listen: false);
              try {
                await currentOrder.addOrder(
                  widget.cart.itemsTotal,
                  widget.cart.items.values.toList(),
                );
                widget.cart.clear();
              } catch (error) {}
               setState(() {
                _isLoading = false;
              });
              // Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
    );
  }
}
