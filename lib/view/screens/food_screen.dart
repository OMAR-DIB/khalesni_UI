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
                  height: MediaQuery.of(context).size.height *
                      0.4, // 40% of the screen height
                  color: Colors.orange,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_sharp),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.orange[200]!),
                        ),
                      ),
                      Text("Food Details"),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.heart_broken),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.orange[200]!),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("data")],
                    )),
              ],
            ),
            // Positioned CircleAvatar

            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.35, // Position under orange section
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                padding: const EdgeInsets.only(
                    top: 130, left: 16, right: 16), // Adjust for spacing
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the start
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8), // Spacing between name and price
                    Text(
                      '\$${food.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // CircleAvatar for the food image
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25, // Adjust position
              left: MediaQuery.of(context).size.width / 2 -
                  100, // Center the image
              child: CircleAvatar(
                radius: 100, // Adjust size
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

          //       Padding(
          //         padding: const EdgeInsets.all(12.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               food.name,
          //               style: const TextStyle(
          //                   fontSize: 20, fontWeight: FontWeight.bold),
          //             ),
          //             Text(
          //               food.price.toString(),
          //               style: TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold,
          //                   color:
          //                       Theme.of(context).colorScheme.inversePrimary),
          //             ),
          //             Text(food.description),
          //             const SizedBox(height: 16),
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
          //             Consumer<AddOnProvider>(
          //               builder: (context, controller, child) => MyButton(
          //                 text: "ADD TO CARd",
          //                 onTap: () {
          //                   controller.addItemToCart(
          //                       food, controller.selectedAddons, context);
          //                   Navigator.of(context).pop();
          //                 },
          //                 color: Theme.of(context).colorScheme.inversePrimary,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
