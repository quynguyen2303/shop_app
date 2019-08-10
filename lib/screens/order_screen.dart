import 'package:flutter/material.dart';
import '../providers/order.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (context, int) => OrderItem(ordersData.orders[int])),
    );
  }
}
