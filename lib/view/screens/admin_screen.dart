import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/view/screens/admin_food_screen.dart';
import 'package:http/http.dart' as http;

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List foodItems = [];

  @override
  void initState() {
    super.initState();
    fetchFoodItems();
  }

  Future<void> fetchFoodItems() async {
    final response = await http
        .get(Uri.parse('http://localhost/khalesni/api/getFoodAndAddones.php'));
    if (response.statusCode == 200) {
      setState(() {
        foodItems = json.decode(response.body);
      });
    }
  }

void deleteFoodItem(int id) async {
  // Construct the URL with the id in the endpoint
  final url = Uri.parse('http://localhost/khalesni/api/deleteProduct.php');

  // Make the DELETE request
  final response = await http.delete(
    url,
    headers: {
      "Content-Type": "application/json",
      "ID": id.toString(),
    },
  );

  // Refresh the list and show a Snackbar
  fetchFoodItems();
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Success: ${data['message']}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${data['message']}")),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to delete the item.")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final food = foodItems[index];
          List<Addones> addons = (food['addons'] as List<dynamic>)
              .map((addonJson) => Addones.fromJson(addonJson))
              .toList();
          return ListTile(
            title: Text(food['name']),
            subtitle: Text("Price: ${food['price']}"),
            leading: Image.asset(
              "${food['imgPath']}",
              width: 30,
              height: 30,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AdminFoodScreen(
                          food: Food(
                              id: food['id'],
                              name: food['name'],
                              price:double.parse(food['price']) ,
                              description: food['description'],
                              imgPath: food['imgPath'],
                              categoryId: food['category_id'],
                              categoryName: food['category_name'],
                              quantity: int.parse(food['quantity']) ,
                              addons: addons),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteFoodItem(int.parse(food['id']));
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Food Screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
