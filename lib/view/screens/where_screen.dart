
import 'package:flutter/material.dart';
import 'package:gradution_project/main.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/routes/app_route.dart';
import 'package:provider/provider.dart';

class WhereScreen extends StatelessWidget {
  const WhereScreen({super.key});
  @override
  Widget build(BuildContext context) {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
    return Consumer<Restaurant>(
      builder:  (context, restaurant, child) {
        final userCart = restaurant.cart;
        final totalPrice = restaurant.getTotalPrice();

      return Scaffold(
        appBar: AppBar(
          title: const Text('Drop Location'),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
      
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Phone Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              const Text(
                'Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your location',
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle cash payment logic here
                      restaurant.addOrder( userCart,shared.getInt('id')!, locationController.text, phoneController.text);
                      phoneController.clear();
                      locationController.clear();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      showSnackbar(context, 'cash Payment Selected');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Cash'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      restaurant.addOrder(userCart,shared.getInt('id')!, locationController.text, phoneController.text);
                      // Handle visa payment logic here
                      print('Visa Payment Selected');
                      Navigator.pushNamed(context, AppRoute.payment);
      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: const Text('By Visa'),
                  ),
                ],
              ),
              const SizedBox(height: 32,),
              const Center(child: Icon(Icons.delivery_dining_sharp,color: Colors.orange,size: 155,)),
            ],
          ),
        ),
      );
      }
    );

  }
}