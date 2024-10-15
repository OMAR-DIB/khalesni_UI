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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            "Deliver now",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          GestureDetector(
            onTap: ()=> openLocationSearchBox(context) ,
            child: Row(
              children: [
                Text("6566 Tripoli",style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  
                ),),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          )
        ],
      ),
    );
  }
}
