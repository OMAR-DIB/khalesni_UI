
import 'package:flutter/material.dart';
import 'package:gradution_project/routes/app_route.dart';

class WhereScreen extends StatelessWidget {
  const WhereScreen({super.key});
  @override
  Widget build(BuildContext context) {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Number',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your phone number',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            Text(
              'Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your location',
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle cash payment logic here
                    Navigator.of(context).pop();
                    print('Cash Payment Selected');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text('Cash'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle visa payment logic here
                    print('Visa Payment Selected');
                          Navigator.pushNamed(context, AppRoute.payment);

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text('By Visa'),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}