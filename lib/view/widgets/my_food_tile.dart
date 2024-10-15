import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/view/screens/food_screen.dart';

class MyFoodTile extends StatelessWidget {
  final Food food;

  final void Function()? onTap;
  const MyFoodTile({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
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
                      Text(food.name),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$ ${food.price}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        food.description,
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                        width: 10,
                      ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      9), // Adjust the value to make it circular or slightly rounded
                  child: Image.asset(
                    food.imagePath,
                    // width: 120,
                    height: 100,
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
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}
