import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gradution_project/models/cart_item.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/view/widgets/my_food_tile.dart';
import 'package:http/http.dart' as http;

class Restaurant extends ChangeNotifier {
  final String baseUrl = "http://localhost/khalesni/api/";
  final List<Food> _menu = [];
  List<Food> get menu => _menu;

  // Fetch all products from the API
  Future<void> fetchMenu() async {
    try {
      final response = await http.get(Uri.parse("${baseUrl}getAllProduct.php"));
      if (response.statusCode == 200) {
        // Decode the JSON response
        final jsonData = json.decode(response.body);
        print(jsonData);

        // Ensure the response contains the food data
        if (jsonData['food'] != null) {
          // Clear the current menu
          _menu.clear();

          // Parse the food items into the Food model
          List<dynamic> foodList = jsonData['food'];
          foodList.forEach((item) {
            _menu.add(Food(
              id: item['id'],
              name: item['name'],
              price: double.parse(item['price'].toString()),
              description: item['description'],
              imgPath: item['imgPath'],
              categoryId: item['category_id'],
              categoryName: item['category_name'],
              quantity: int.parse(item['quantity'].toString()),
              addons: (item['addons'] as List)
                  .map((addon) => Addones.fromJson(addon))
                  .toList(),
            ));
          });

          // Notify listeners to update the UI
          notifyListeners();
        } else {
          throw Exception("No food data in the response");
        }
      } else {
        throw Exception("Failed to fetch menu: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching menu:: $error");
    }
  }

  // Filter menu by category
  List<Food> filterMenuByCategory(String categoryId, List<Food> fullMenu) {
    return fullMenu.where((food) => food.categoryId == categoryId).toList();
  }

  // Generate filtered food widgets
  List<Widget> getFilteredFood(List<Food> fullMenu) {
    // Extract unique categories from the full menu
    final categories = fullMenu
        .map((food) => {'id': food.categoryId, 'name': food.categoryName})
        .toSet()
        .toList();

    // Map categories to ListViews
    return categories.map((category) {
      List<Food> categoryMenu = filterMenuByCategory(category['id']!, fullMenu);

      // Build a ListView for each category
      return ListView.builder(
        itemCount: categoryMenu.length,
        itemBuilder: (context, index) {
          return MyFoodTile(
            food: categoryMenu[index],
            onTap: () {
              // Handle onTap event here
            },
          );
        },
      );
    }).toList();
  }

  // Cart operations
  final List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;

  void addToCart(Food food, List<Addones> selectedAddons) {
    // Helper function to compare two lists of Addon objects
    bool _areAddonsSame(List<Addones> list1, List<Addones> list2) {
      if (list1.length != list2.length) return false;
      for (int i = 0; i < list1.length; i++) {
        if (list1[i] != list2[i]) return false;
      }
      return true;
    }

    // Function to find matching cart item
    CartItem? _findCartItem(Food food, List<Addones> selectedAddons) {
      for (var item in _cart) {
        if (item.food == food &&
            _areAddonsSame(item.selectedAddons, selectedAddons)) {
          return item;
        }
      }
      return null;
    }

    // Find the item in the cart
    CartItem? cartItem = _findCartItem(food, selectedAddons);

    // If item exists, increase quantity, otherwise add new item
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    int index = _cart.indexOf(cartItem);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        cartItem.quantity--;
      } else {
        _cart.removeAt(index);
      }
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addones addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  int getNbOfItemInCart() {
    return _cart.length;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
