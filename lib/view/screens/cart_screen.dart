import 'package:flutter/material.dart';
import 'package:gradution_project/controller/user_controller.dart';
import 'package:gradution_project/main.dart';
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
        final totalPrice = restaurant.getTotalPrice();
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                onPressed: () {
                  if (userCart.isNotEmpty) {
                    clearCartDialog(context, restaurant); // Clear cart dialog
                  }
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: userCart.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart_outlined,
                                size: screenWidth * 0.25, color: Colors.grey),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              "Your cart is empty!",
                              style: TextStyle(
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Navigate back to menu
                              },
                              child: const Text("Browse Menu"),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          final cartItem = userCart[index];
                          return MyCartTile(cartItem: cartItem);
                        },
                      ),
              ),
              if (userCart.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      MyButton(
                        text: "Checkout",
                        onTap: () {
                          restaurant.addOrder( userCart,shared.getInt('id')!);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PaymentScreen(),
                            ),
                          );
                        },
                        width: double.infinity,
                        height: screenHeight * 0.09,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
