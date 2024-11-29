import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/view/widgets/my_current_location.dart';
import 'package:gradution_project/view/widgets/my_description_box.dart';
import 'package:gradution_project/view/widgets/my_drawer.dart';
import 'package:gradution_project/view/widgets/my_food_tile.dart';
import 'package:gradution_project/view/widgets/my_silver_app_bar.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Restaurant restaurantProvider;

  @override
  void initState() {
    super.initState();
    // Fetch menu data when the widget initializes
    restaurantProvider = Restaurant();
   restaurantProvider.fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<Restaurant>.value(
      value: restaurantProvider,
      child: Builder(
        builder: (context) => Scaffold(
          drawer: const MyDrawer(),
          body: Consumer<Restaurant>(
            builder: (context, restaurant, child) {
              // Display loading indicator while fetching the menu
              if (restaurant.menu.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Extract unique categories from the menu
              final categories = restaurant.menu
                  .map((food) => {'id': food.categoryId, 'name': food.categoryName})
                  .toSet()
                  .toList();

              return DefaultTabController(
                length: categories.length, // Number of tabs matches categories
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    MySilverAppBar(
                      title: const Text("M E N U"),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const MyCurrentLocation(),
                          const MyDescriptionBox(),
                          TabBar(
                            isScrollable: true, // Tabs can scroll
                            tabs: categories
                                .map((category) => Text(
                                      category['name']!,
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.036,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                  body: TabBarView(
                    children: categories.map((category) {
                      final categoryMenu = restaurant.filterMenuByCategory(
                        category['id']!,
                        restaurant.menu,
                      );

                      if (categoryMenu.isEmpty) {
                        return Center(
                          child: Text("No items available in this category"),
                        );
                      }

                      return ListView.builder(
                        itemCount: categoryMenu.length,
                        itemBuilder: (context, index) {
                          return MyFoodTile(
                            food: categoryMenu[index],
                            onTap: () {
                              // Handle onTap
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
