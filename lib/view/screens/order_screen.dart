import 'package:flutter/material.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  void initState() {
    super.initState();
    // Ensure fetchAllOrders is called on widget initialization
    context.read<Restaurant>().fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Restaurant>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: FutureBuilder(
        future: orderProvider.fetchAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load orders: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                final order = orderProvider.orders[index];
                return ListTile(
                  title: Text('Order #${order.id}'),
                  subtitle: Text(order.status),
                );
              },
            );
          }
        },
      ),
    );
  }
}
