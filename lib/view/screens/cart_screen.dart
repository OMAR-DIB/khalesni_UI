import 'package:flutter/material.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/view/screens/payment_screen.dart';
import 'package:gradution_project/view/widgets/clear_cart_dialog.dart';
import 'package:gradution_project/view/widgets/my_button.dart';
import 'package:gradution_project/view/widgets/my_cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cartt"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                  onPressed: () {
                    if (userCart.isNotEmpty) {
                      clearCartDialog(context, restaurant);
                    }
                  },
                  icon: const Icon(Icons.delete)),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ?  Expanded(
                            child: Center(
                              child: Text("Go and SeLeCt your FoOd",style: TextStyle(
                                fontSize: screenWidth * 0.07
                              ),),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                final cartItem = userCart[index];
                                return MyCartTile(cartItem: cartItem);
                              },
                            ),
                          ),
                  ],
                ),
              ),
              MyButton(
                  text: "cHeCkOuT",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PaymentScreen(),
                      ),
                    );
                  },
                  width: double.infinity,
                  height:   screenHeight * 0.09,
                  ),
              // SizedBox(
              //   height: screenHeight * 0.01,
              // ),
            ],
          ),
        );
      },
    );
  }
}
