import 'package:flutter/material.dart';
import 'package:gradution_project/models/restaurant.dart';

Future<dynamic> clearCartDialog(BuildContext context, Restaurant restaurant) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Are you shure do you want to free your cart"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            restaurant.clearCart();
          },
          child: const Text("fReE CaRt"),
        ),
      ],
    ),
  );
}
