import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';
import 'package:http/http.dart' as http;

class AdminFoodScreen extends StatefulWidget {
   final Food? food; 
  const AdminFoodScreen({this.food});

  @override
  State<AdminFoodScreen> createState() => _AdminFoodScreenState();
}

class _AdminFoodScreenState extends State<AdminFoodScreen> {
  
   final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.food != null) {
      nameController.text = widget.food!.name;
      priceController.text = widget.food!.price.toString();
    }
  }

  void saveFood() async {
    final url = widget.food == null
        ? 'http://localhost/khalesni/api/'
        : 'http://localhost/khalesni/api/food/${widget.food!.id}';

    final response = widget.food == null
        ? await http.post(Uri.parse(url), body: {
            'name': nameController.text,
            'price': priceController.text,
          })
        : await http.put(Uri.parse(url), body: {
            'name': nameController.text,
            'price': priceController.text,
          });

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pop(context, true); // Success
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.food == null ? "Add Food" : "Edit Food"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveFood,
                child: Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}