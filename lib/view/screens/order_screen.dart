import 'package:flutter/material.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<void> _fetchOrdersFuture;

  @override
  void initState() {
    super.initState();
    // Cache the Future to avoid repeated fetches
    _fetchOrdersFuture = context.read<Restaurant>().fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Restaurant>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: FutureBuilder(
        future: _fetchOrdersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load orders: ${snapshot.error}'));
          } else {
            if (orderProvider.orders.isEmpty) {
              return Center(child: Text('No orders available.'));
            }

            return ListView.builder(
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                final order = orderProvider.orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID: ${order.id}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text('Status: ${order.status}'),
                        SizedBox(height: 8),
                        Text('Customer: ${order.userName}'),
                        SizedBox(height: 8),
                        Divider(),
                        ListTile(
                          title: Text(order.items.name),
                          subtitle: Text(
                              'Quantity: ${order.items.quantity}\nTotal Price: \$${order.totalPrice.toStringAsFixed(2)}'),
                          leading: Image.asset(
                            order.items.imgPath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          trailing: Text('\$${order.items.price.toStringAsFixed(2)}'),
                        ),
                        if (order.items.addons.isNotEmpty) ...[
                          SizedBox(height: 8),
                          Text(
                            'Add-ons:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...order.items.addons.map((addon) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text('${addon.name} (\$${addon.price.toStringAsFixed(2)})'),
                            );
                          }).toList(),
                        ]
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
