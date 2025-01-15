import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gradution_project/controller/addon_provider.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/view/screens/food_screen.dart';
import 'package:provider/provider.dart';

class MyFoodTile extends StatelessWidget {
  final Food food;
  // final void Function()? onTap;
  // final void Function()? onPress;

  const MyFoodTile(
      {super.key,
      required this.food,
      });

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
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          margin: EdgeInsets.only(
              top: 0,
              ), // Reduced margin for grid
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.background,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 186, 186, 186),
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
                  icon: const Icon(Icons.favorite_border),
                ),
              ]),
              Center(
                child: CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.file(
                      File(food.imgPath),
                      height: screenHeight * 0.11, // Adjusted height for images
                      width: double.infinity,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: 0,
                    left:  0,
                    bottom: 0,
                    top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        food.name,
                        style: TextStyle(
                            fontSize: screenHeight * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("10-20 min"),
                        TextButton.icon(
                          onPressed: () {},
                          label: const Text("4.5"),
                          icon:const  Icon(
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
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '\$${food.price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextButton.icon(
                            onPressed: (){
                              Provider.of<AddOnProvider>(context,listen: false).addItemToCart(food,{}, context);
                            },
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
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(
                                          20)), // Set to 0.0 for rectangular shape
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
      ),
    );
  }
}
