import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gradution_project/controller/addon_provider.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/view/widgets/my_button.dart';
import 'package:provider/provider.dart';

class FoodScreen extends StatelessWidget {
  final Food food;
  const FoodScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => Restaurant(),
        // ),
        ChangeNotifierProvider(
          create: (_) {
            final controller = AddOnProvider();
            controller.initializeAddons(food.addons);
            return controller;
          },
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: Colors.orange,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back_ios_sharp),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "Food Details",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              
                            },
                            icon: const Icon(Icons.favorite_border),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(45), // Rounded top-left corner
                            topRight:
                                Radius.circular(45), // Rounded top-right corner
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '\$${food.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange[500],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                 Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange[300],
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Text("4.5"),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.local_fire_department_rounded,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text("100 cal"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later,
                              color: Colors.orange[300],
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Text("20 min"),
                          ],
                        ),
                      ],
                    ),
                                const SizedBox(height: 4),
                                const Text(
                                  "About Food",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(food.description),
                                const SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Consumer<AddOnProvider>(
                                    builder: (context, controller, child) =>
                                        ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: food.addons.length,
                                      itemBuilder: (context, index) {
                                        Addones addon = food.addons[index];
                                        return CheckboxListTile(
                                          title: Text(food.addons[index].name),
                                          subtitle: Text(
                                            '\$${food.addons[index].price.toString()}',
                                          ),
                                          value:
                                              controller.selectedAddons[addon],
                                          onChanged: (value) {
                                            controller.toggleAddon(addon);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Consumer<AddOnProvider>(
                          builder: (context, controller, child) => MyButton(
                            width: double.infinity,
                            height: 50,
                            text: "ADD TO CART",
                            onTap: () {
                              controller.addItemToCart(
                                  food, controller.selectedAddons, context);
                              Navigator.of(context).pop();
                            },
                            color: Colors.orange[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Positioned CircleAvatar
            Positioned(
              top: MediaQuery.of(context).size.height * 0.10,
              left: MediaQuery.of(context).size.width / 2 - 100,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.file(
                    File(food.imgPath),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          ],

          //             // Ensure ListView has a height
          //             Text(
          //               "Available Add-ons:",
          //               style: TextStyle(
          //                   color:
          //                       Theme.of(context).colorScheme.inversePrimary),
          //             ),
          //             const SizedBox(height: 8),
          //             // Use Expanded to allow ListView to take available space
          //             Container(
          //               decoration: BoxDecoration(
          //                   border: Border.all(
          //                     color: Theme.of(context).colorScheme.secondary,
          //                   ),
          //                   borderRadius: BorderRadius.circular(8)),
          //               child: Consumer<AddOnProvider>(
          //                 builder: (context, controller, child) =>
          //                     ListView.builder(
          //                   shrinkWrap: true,
          //                   physics: const NeverScrollableScrollPhysics(),
          //                   itemCount: food.addons.length,
          //                   itemBuilder: (context, index) {
          //                     Addones addon = food.addons[index];
          //                     return CheckboxListTile(
          //                       title: Text(food.addons[index].name),
          //                       subtitle: Text(
          //                         '\$${food.addons[index].price.toString()}',
          //                       ),

          //                       value: controller.selectedAddons[
          //                           addon], // Replace with proper state handling for each checkbox
          //                       onChanged: (value) {
          //                         controller.toggleAddon(addon);
          //                       },
          //                     );
          //                   },
          //                 ),
          //               ),
          //             ),
          //
        ),
      ),
    );
  }
}

// class FoodScreen extends StatelessWidget {
//   final Food food;
//   const FoodScreen({super.key, required this.food});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // ChangeNotifierProvider(
//         //   create: (context) => Restaurant(),
//         // ),
//         ChangeNotifierProvider(
//           create: (_) {
//             final controller = AddOnProvider();
//             controller.initializeAddons(food.addons);
//             return controller;
//           },
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Food Details"),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Image.file(
//                 File(food.imgPath),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       food.name,
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       food.price.toString(),
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).colorScheme.inversePrimary),
//                     ),
//                     Text(food.description),
//                     const SizedBox(height: 16),
//                     // Ensure ListView has a height
//                     Text(
//                       "Available Add-ons:",
//                       style: TextStyle(
//                           color: Theme.of(context).colorScheme.inversePrimary),
//                     ),
//                     const SizedBox(height: 8),
//                     // Use Expanded to allow ListView to take available space
//                     Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).colorScheme.secondary,
//                           ),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Consumer<AddOnProvider>(
//                         builder: (context, controller, child) =>
//                             ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: food.addons.length,
//                           itemBuilder: (context, index) {
//                             Addones addon = food.addons[index];
//                             return CheckboxListTile(
//                               title: Text(food.addons[index].name),
//                               subtitle: Text(
//                                 '\$${food.addons[index].price.toString()}',
//                               ),

//                               value: controller.selectedAddons[
//                                   addon], // Replace with proper state handling for each checkbox
//                               onChanged: (value) {
//                                 controller.toggleAddon(addon);
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     Consumer<AddOnProvider>(
//                       builder: (context, controller, child) => MyButton(
//                         text: "ADD TO CARd",
//                         onTap: () {
//                           controller.addItemToCart(
//                               food, controller.selectedAddons, context);
//                               Navigator.of(context).pop();
//                         },
//                         color: Theme.of(context).colorScheme.inversePrimary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
