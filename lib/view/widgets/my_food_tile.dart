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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(screenHeight * 0.006),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FoodScreen(food: food),),);
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(food.name,style: TextStyle(fontSize: screenHeight*0.03),),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '\$ ${food.price}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: screenHeight*0.025),
                      ),
                      const SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        food.description,
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary,fontSize: screenHeight*0.025),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                        width: screenWidth * 0.01,
                      ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      screenHeight*0.01), // Adjust the value to make it circular or slightly rounded
                  child: Image.asset(
                    food.imgPath,
                    // width: 120,
                    height: screenHeight*0.2,
                    fit: BoxFit
                        .cover, // Ensures the image fits within the rounded border
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.tertiary,
          indent: 5,
          endIndent: 5,
        ),
      ],
    );
  }
}
