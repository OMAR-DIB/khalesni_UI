import 'package:flutter/material.dart';
import 'package:gradution_project/controller/addon_provider.dart';
import 'package:gradution_project/models/food.dart';

import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/view/widgets/my_button.dart';
import 'package:provider/provider.dart';

class FoodScreen extends StatelessWidget {

  final Food food;
  const FoodScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Restaurant(),  
        ),
        ChangeNotifierProvider(
      create: (_) {
        final controller = AddOnProvider();
        controller.initializeAddons(food.availableAddon);
        return controller;
      },
      ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                food.imagePath,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle( fontSize: 20,fontWeight: FontWeight.bold ),
                    ),
                    Text(
                      food.price.toString(),
                      style: TextStyle( fontSize: 20,fontWeight: FontWeight.bold ,color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    Text(food.description),
                    const SizedBox(height: 16),
                    // Ensure ListView has a height
                    Text("Available Add-ons:", style: TextStyle( color: Theme.of(context).colorScheme.inversePrimary ),),
                    const SizedBox(height: 8),
                    // Use Expanded to allow ListView to take available space
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.secondary,
                        ),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Consumer<AddOnProvider>(
                        builder: (context,controller, child) =>ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: food.availableAddon.length,
                          itemBuilder: (context, index) {
                            Addon addon = food.availableAddon[index];
                            return CheckboxListTile(
                              title: Text(food.availableAddon[index].name),
                              subtitle: Text(
                                '\$${food.availableAddon[index].price.toString()}',
                              ),
                             
                              value: controller.selectedAddons[addon],// Replace with proper state handling for each checkbox
                              onChanged: (value) {
                                controller.toggleAddon(addon);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Consumer<AddOnProvider>(
                      builder: (context, controller, child) => MyButton(text: "ADD TO CARd", onTap: (){
                      controller.addItemToCart(food, controller.selectedAddons, context);
                      
                      },color: Theme.of(context).colorScheme.inversePrimary,),
                    ),
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