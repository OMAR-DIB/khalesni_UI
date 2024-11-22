import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/view/widgets/my_current_location.dart';
import 'package:gradution_project/view/widgets/my_description_box.dart';
import 'package:gradution_project/view/widgets/my_drawer.dart';
import 'package:gradution_project/view/widgets/my_silver_app_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Screen dimensions for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => Restaurant(),
      child: Builder(
        builder: (context) => DefaultTabController(
          length: FoodCategory.values.length, // Number of tabs
          child: Scaffold(
            drawer: const MyDrawer(),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                MySilverAppBar(
                  title: const Text("M E N U"),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Divider(
                      //   indent: screenWidth * 0.01,
                      //   endIndent: screenWidth * 0.01,
                      //   color: Theme.of(context).colorScheme.secondary,
                      // ),
                      const MyCurrentLocation(),
                      const MyDescriptionBox(),
                      TabBar(
                        isScrollable:
                            true, // Allows the tabs to scroll if needed
                        tabs: FoodCategory.values
                            .map((e) => Text(
                                  e.name,
                                  style: TextStyle(
                                    fontSize: screenHeight *
                                        0.036, // Responsive font size
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
              body: Consumer<Restaurant>(
                builder: (context, restaurant, child) => TabBarView(
                  children: restaurant.getFiltredFood(restaurant.menu),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
