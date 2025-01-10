import 'package:flutter/material.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(screenHeight * 0.02),
      margin: EdgeInsets.only(
        left: screenWidth * 0.02,
        right: screenWidth * 0.02,
        bottom: screenHeight * 0.01,
        top: screenHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '\$0.99',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: screenHeight * 0.025,
                ),
              ),
              Text(
                'Delivery fee',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: screenHeight * 0.025,
                ),
              ),
            ],
          ),
          Consumer<Restaurant>(
            builder: (context, value, child) {
              final totalPrice = value.getTotalPrice();
              return Column(
                children: [
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: screenHeight * 0.025,
                    ),
                  ),
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: screenHeight * 0.025,
                    ),
                  ),
                ],
              );
            },
          ),
          Column(
            children: [
              Text(
                '25-25 min',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: screenHeight * 0.025,
                ),
              ),
              Text(
                'Delivery time',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: screenHeight * 0.025,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
