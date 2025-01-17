import 'package:flutter/material.dart';
import 'package:gradution_project/routes/app_route.dart';
import 'package:gradution_project/view/screens/add_new_item.dart';
import 'package:gradution_project/view/screens/admin_screen.dart';
import 'package:gradution_project/view/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:gradution_project/view/screens/admin_screen.dart';
import 'package:gradution_project/view/screens/order_screen.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  int _currentIndex = 0; // Declare _currentIndex as a stateful field.

  // Pages for navigation
  final List<Widget> _pages = [
    AdminScreen(),
    AddNewItem(),
    OrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text(_currentIndex == 0 ? 'Admin Panel':_currentIndex == 1 ? "Add New Product" : 'Orders'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, AppRoute.login);
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: _pages[_currentIndex], // Switch between pages based on _currentIndex.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update _currentIndex and rebuild the widget.
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}
