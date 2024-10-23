import 'package:flutter/material.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/view/widgets/my_cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cartt"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(itemCount: userCart.length,itemBuilder: (context,index){
                  final cartItem = userCart[index];
                  return MyCartTile(cartItem: cartItem);
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
