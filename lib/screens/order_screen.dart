import 'package:flutter/material.dart';
import '../providers/order.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              // Handling the error
              print(dataSnapshot.error);
              return Center(
                child: Text('Got an error.'),
              );
            } else {
              return Consumer<Orders>(
                  builder: (context, ordersData, child) => ListView.builder(
                      itemCount: ordersData.orders.length,
                      itemBuilder: (context, int) =>
                          OrderItem(ordersData.orders[int])));
            }
          }
        },
      ),
    );
  }
}
