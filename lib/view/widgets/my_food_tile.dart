import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/view/screens/food_screen.dart';

class MyFoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const MyFoodTile({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FoodScreen(food: food),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
            top: 0,
            bottom: screenHeight * 0.01,
            left: screenHeight * 0.02,
            right: screenHeight * 0.02), // Reduced margin for grid
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenHeight * 0.01),
          // color: Theme.of(context).colorScheme.background,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.heart_broken),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.file(
                  File(food.imgPath),
                  height: screenHeight * 0.13, // Adjusted height for images
                  width: double.infinity,
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right:screenHeight * 0.01 , left: screenHeight * 0.01,bottom: 0,top: screenHeight * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("10-20 min"),
                      TextButton.icon(
                        onPressed: () {},
                        label: const Text("4.5"),
                        icon: Icon(
                          Icons.star,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                  Column(
                    children: [
                      Text(
                        '\$${food.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextButton.icon(
                          onPressed: () {},
                          label: const Text(""),
                          icon: Icon(
                            Icons.add,
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.orange),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                               const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),// Set to 0.0 for rectangular shape
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )

                  // Text(
                  //   food.description,
                  //   style: TextStyle(
                  //     color: Theme.of(context).colorScheme.onBackground,
                  //     fontSize: screenHeight * 0.02,
                  //   ),
                  //   maxLines: 2, // Limit the description lines
                  //   overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
