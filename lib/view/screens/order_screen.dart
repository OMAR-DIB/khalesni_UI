import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart'; // For grouping

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
    _fetchOrdersFuture = context.read<Restaurant>().fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Restaurant>(context);

    return Scaffold(
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

            final groupedOrders = groupBy(orderProvider.orders, (Order order) => order.id);

            return ListView.builder(
              itemCount: groupedOrders.keys.length,
              itemBuilder: (context, index) {
                final orderId = groupedOrders.keys.elementAt(index);
                final orders = groupedOrders[orderId]!;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer: ${orders.first.userName}'),
                        SizedBox(height: 8),
                        Text('Status: ${orders.first.status}'),
                        SizedBox(height: 8),
                        Text('Phone Number: ${orders.first.phoneNumber}'),
                        SizedBox(height: 8),
                        Text('Location: ${orders.first.location}'),
                        SizedBox(height: 8),
                        Text(
                          'Total Price: \$${orders.first.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Divider(),
                        ...orders.map((order) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(order.items.name),
                                subtitle: Text('Quantity: ${order.items.quantity}\n'),
                                leading: Image.file(
                                  File(order.items.imgPath),
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
                              ],
                            ],
                          );
                        }).toList(),
                        SizedBox(height: 8),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Delete Order'),
                                  content: Text('Are you sure you want to delete this order?'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
                                    TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Delete')),
                                  ],
                                );
                              },
                            );

                            if (shouldDelete ?? false) {
                              await orderProvider.deleteOrder(orderId);
                              setState(() {}); // Refresh UI
                            }
                          },
                        ),
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

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({super.key});

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   late Future<void> _fetchOrdersFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Cache the Future to avoid repeated fetches
//     _fetchOrdersFuture = context.read<Restaurant>().fetchAllOrders();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderProvider = Provider.of<Restaurant>(context);

//     return Scaffold(
//       body: FutureBuilder(
//         future: _fetchOrdersFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//                 child: Text('Failed to load orders: ${snapshot.error}'));
//           } else {
//             if (orderProvider.orders.isEmpty) {
//               return Center(child: Text('No orders available.'));
//             }

//             // Group orders by ID
//             final groupedOrders =
//                 groupBy(orderProvider.orders, (Order order) => order.id);

//             return ListView.builder(
//               itemCount: groupedOrders.keys.length,
//               itemBuilder: (context, index) {
//                 final orderId = groupedOrders.keys.elementAt(index);
//                 final orders = groupedOrders[orderId]!;

//                 return Container(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                         color: Colors.grey, width: 1), // Border settings
//                     borderRadius: BorderRadius.circular(8), // Rounded corners
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Display customer details
//                         Text('Customer: ${orders.first.userName}'),
//                         SizedBox(height: 8),
//                         Text('Status: ${orders.first.status}'),
//                         SizedBox(height: 8),
//                         Text('Phone Number: ${orders.first.phoneNumber} '),
//                         SizedBox(height: 8),
//                         Text('Location: ${orders.first.location} '),
//                         SizedBox(height: 8),
//                         Text(
//                           'Total Price: \$${orders.first.totalPrice.toStringAsFixed(2)}',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16),
//                         ),
//                         SizedBox(height: 8),
//                         Divider(),
//                         ...orders.map((order) {
//                           return ListTile(
//                             title: Text(order.items.name),
//                             subtitle:
//                                 Text('Quantity: ${order.items.quantity}\n'),
//                             leading: Image.file(
//                               File(order.items.imgPath),
//                               width: 50,
//                               height: 50,
//                               fit: BoxFit.cover,
//                             ),
//                             trailing: Text(
//                                 '\$${order.items.price.toStringAsFixed(2)}'),
//                           );
//                         }).toList(),
//                         if (orders.first.items.addons.isNotEmpty) ...[
//                           SizedBox(height: 8),
//                           Text(
//                             'Add-ons:',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           ...orders.first.items.addons.map((addon) {
//                             return Padding(
//                               padding: const EdgeInsets.only(left: 8.0, top: 4),
//                               child: Text(
//                                   '${addon.name} (\$${addon.price.toStringAsFixed(2)})'),
//                             );
//                           }).toList(),
//                           SizedBox(height: 8,),
//                           IconButton(
//                               icon: Icon(Icons.delete, color: Colors.red),
//                               onPressed: () async {
//                                 // Confirm deletion
//                                 final shouldDelete = await showDialog<bool>(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       title: Text('Delete Order'),
//                                       content: Text(
//                                           'Are you sure you want to delete this order?'),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () =>
//                                               Navigator.pop(context, false),
//                                           child: Text('Cancel'),
//                                         ),
//                                         TextButton(
//                                           onPressed: () =>
//                                               Navigator.pop(context, true),
//                                           child: Text('Delete'),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );

//                                 if (shouldDelete ?? false) {
//                                   await orderProvider.deleteOrder(orderId);
//                                   setState(() {}); // Refresh UI
//                                 }
//                               },
//                             ),
//                         ]
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
