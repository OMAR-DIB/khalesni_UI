import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gradution_project/models/cart_item.dart';
import 'package:gradution_project/view/widgets/my_quantity_selector.dart';
import 'package:provider/provider.dart';
import 'package:gradution_project/models/restaurant.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 233, 230, 230),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenWidth * 0.03,
                  left: screenWidth * 0.05),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(cartItem.food.imgPath),
                      width: screenWidth * 0.2,
                      // height: screenHeight * 0.11,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
                  Column(
                    children: [
                      Text(cartItem.food.name,style: TextStyle(
                        fontSize: screenWidth * 0.05,
                      ),),
                      Text("\$ ${cartItem.food.price}",style: TextStyle(
                        fontSize: screenWidth * 0.05,
                      ),)
                    ],
                  ),
                  const Spacer(),
                  MyQuantitySelector(
                      quantity: cartItem.quantity,
                      food: cartItem.food,
                      onIncrement: () {
                        restaurant.removeFromCart(cartItem);
                      },
                      onDecrement: () {
                        restaurant.addToCart(
                            cartItem.food, cartItem.selectedAddons);
                      }),
                ],
              ),
            ),
            
            Padding(
              padding: EdgeInsets.only(
                  bottom: screenWidth * 0.05, left: screenWidth * 0.04),
              child: SizedBox(
                height:
                    cartItem.selectedAddons.isEmpty ? 0 : screenHeight * 0.07,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: cartItem.selectedAddons
                      .map(
                        (addon) => FilterChip(
                          label: Row(
                            children: [
                              Text(addon.name,style: TextStyle(
                                fontSize: screenHeight *0.02,
                              ),),
                              Text("\$ ${addon.price}",style: TextStyle(
                                fontSize: screenHeight *0.02,
                              ),)
                            ],
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(
                            color: Colors.white,
                          )),
                          onSelected: (Value) {},
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: screenWidth * 0.02,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
