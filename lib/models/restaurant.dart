import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gradution_project/models/cart_item.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/view/widgets/my_food_tile.dart';
import 'package:http/http.dart' as http;

class Order {
  final int id;
  final String status;
  final String userName;
  final String location;
  final String phoneNumber;
  final Food items; // Add this field
  final double totalPrice;

  Order({
    required this.id,
    required this.status,
    required this.userName,
    required this.items, // Include this parameter in the constructor
    required this.totalPrice,
    required this.location,
    required this.phoneNumber
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['order_id'] ?? 0,
      status: json['status'] ?? 'Unknown',
      userName: json['user_name'] ?? 'Guest',
      location: json['location'] ?? 'Unknown',
      phoneNumber: json['phoneNumber'] ?? 'phoneNumber',
      items: Food(
        id: json['items']['food_id']?.toString() ?? '',
        name: json['items']['food_details']['name'] ?? 'Unknown',
        price: (json['items']['food_details']['price'] ?? 0).toDouble(),
        description: '', // Optional
        imgPath: json['items']['food_details']['imgPath'] ?? '',
        categoryId: '', // Optional
        categoryName: '', // Optional
        quantity: json['items']['quantity'] ?? 0,
        addons: [
          Addones(
            id: json['items']['addones_id']?.toString() ?? '',
            name: json['items']['addons']['name'] ?? 'None',
            price: (json['items']['addons']['price'] ?? 0).toDouble(),
          )
        ],
      ),
      totalPrice: (json['items']['total_price'] ?? 0).toDouble(),
    );
  }
}

class Restaurant extends ChangeNotifier {
  final String baseUrl = "http://localhost/khalesni/api/";
  final List<Food> _menu = [];
  List<Food> get menu => _menu;
  final List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;

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
            // onTap: () {
            //   // Handle onTap event here
            // },
          );
        },
      );
    }).toList();
  }

  // Cart operations

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

  List<Order> _orders = [];

  Future<void> addOrder(List<CartItem> cartItems, int userId, String location,
      String phoneNumber) async {
    try {
      // Create a list of order items with the specified format
      List<Map<String, dynamic>> orderItems = cartItems.map((item) {
        double addonPrice =
            item.selectedAddons.fold(0, (sum, addon) => sum + addon.price);
        double totalPrice = (item.food.price + addonPrice) * item.quantity;
        return {
          'food_id': item.food.id,
          'addones_id': item.selectedAddons.isNotEmpty
              ? item.selectedAddons[0].id
              : null, // Assuming only one addon for simplicity
          'quantity': item.quantity,
          'location': location,
          'phoneNumber': phoneNumber
        };
      }).toList();

      // Include the user_id and total_price in the main order structure
      final requestData = {
        'user_id': userId,
        'items': orderItems,
        'total_price': getTotalPrice(),
        'location': location,
        'phoneNumber': phoneNumber
      };
      print(json.encode(requestData));
      // POST request to the backend
      final response = await http.post(
        Uri.parse("http://localhost/khalesni/api/addOrder.php"),
        body: json.encode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      // Handle the response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData != null &&
            responseData is Map &&
            responseData.containsKey('message')) {
          // Orders successfully added
          notifyListeners();
        } else {
          throw Exception(responseData['error'] ?? 'Failed to add orders');
        }
      } else {
        throw Exception('Failed to add orders');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAllOrders() async {
    try {
      final response = await http
          .get(Uri.parse("http://localhost/khalesni/api/getAllOrders.php"));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body); // Parse JSON response
        print(data); // Debug: Print the data for verification

        // Map JSON data to the `Order` model
        _orders =
            data.map<Order>((orderJson) => Order.fromJson(orderJson)).toList();

        notifyListeners(); // Notify listeners for UI updates
      } else {
        throw Exception(
            'Failed to load orders with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log or throw the error for better debugging
      print('Error fetching orders: $e');
      throw Exception('Failed to load orders: $e');
    }
  }

  Future<void> deleteOrder(int orderId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/deleteOrder.php"),
      body: {'order_id': orderId.toString()},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }

  // Change order status
  Future<void> changeOrderStatus(int orderId, String status) async {
    final response = await http.post(
      Uri.parse("$baseUrl/changeOrderStatus.php"),
      body: {
        'order_id': orderId.toString(),
        'status': status,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update order status');
    }
  }
  // Additional methods to handle orders, etc.

  List<Order> get orders => _orders;
}
