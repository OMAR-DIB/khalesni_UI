import 'package:flutter/material.dart';
import 'package:gradution_project/models/cart_item.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,restaurant,child) => Container(
      child: Column(children: [
        Row(
          children: [
            Image.asset(cartItem.food.imagePath),
          ],
        )
      ],),
    ));
  }
}