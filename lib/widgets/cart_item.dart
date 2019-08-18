import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40.0,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 8.0,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Remove Item',
              textAlign: TextAlign.center,
            ),
            content: Text('Do you really want to remove this item?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        // margin: EdgeInsets.all(10.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text('$price'),
              ),
            ),
          ),
          title: Text('$title'),
          subtitle: Text('\$${(price * quantity)}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
