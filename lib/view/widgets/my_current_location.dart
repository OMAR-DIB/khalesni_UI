import 'package:flutter/material.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title:const Text("your Location"),
      content: const TextField(
        decoration:  InputDecoration(hintText: "Search Address..."),
      ),
      actions: [
        MaterialButton(onPressed: () => Navigator.of(context).pop(),
        child: const Text("Cancel"),),
      MaterialButton(onPressed: () => Navigator.of(context).pop(),
        child: const Text("Save"),),
      
      ],
    ),);
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          "Deliver now",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: screenHeight * 0.036,
          ),
        ),
        GestureDetector(
          onTap: ()=> openLocationSearchBox(context) ,
          child: Row(
            children: [
              Text("6566 Tripoli",style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.02,
              ),),
              const Icon(Icons.keyboard_arrow_down_rounded)
            ],
          ),
        )
      ],
    );
  }
}
