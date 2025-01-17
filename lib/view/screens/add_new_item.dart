import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;

  // Input fields
  String name = '';
  double price = 0.0;
  String description = '';
  int categoryId = 0;
  String imgPath = '';
  int quantity = 0;

  List<dynamic> addons = [];
  List<int> selectedAddonIds = [];
  List<dynamic> categories = [];

  final ImagePicker _picker = ImagePicker();

Future<void> fetchCategories() async {
  try {
    final response = await http
        .get(Uri.parse('http://localhost/khalesni/api/getAllCategory.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          categories = data['categories'];
        });
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception("Failed to fetch categories.");
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final directory = await getApplicationDocumentsDirectory();
        final newPath = '${directory.path}/${pickedFile.name}';
        final savedImage = await File(pickedFile.path).copy(newPath);

        setState(() {
          imgPath = savedImage.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
  
  Future<void> fetchAddons() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost/khalesni/api/getAllAddones.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            addons = data['addons'];
            isLoading = false;
          });
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception("Failed to fetch addons.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> addProduct() async {
    // Validate the form
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    // Prepare the product data
    final productData = {
      "name": name,
      "price": price,
      "description": description,
      "category_id": categoryId,
      "imgPath": imgPath,
      "quantity": quantity,
      "addons": selectedAddonIds,
    };

    try {
      final response = await http.post(
        Uri.parse('http://localhost/khalesni/api/addNewProduct.php'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(productData),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully!')),
        );
        Navigator.pop(context); // Navigate back after successful addition
      } else {
        throw Exception(responseData['message'] ?? "Failed to add product.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void toggleAddonSelection(int addonId) {
    setState(() {
      if (selectedAddonIds.contains(addonId)) {
        selectedAddonIds.remove(addonId);
      } else {
        selectedAddonIds.add(addonId);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAddons();
    fetchCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) =>
                          value!.isEmpty ? "Name is required" : null,
                      onSaved: (value) => name = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? "Price is required" : null,
                      onSaved: (value) => price = double.parse(value!),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Description'),
                      validator: (value) =>
                          value!.isEmpty ? "Description is required" : null,
                      onSaved: (value) => description = value!,
                    ),
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: categories.map<DropdownMenuItem<int>>((category) {
                        return DropdownMenuItem<int>(
                          value: int.parse(category['id'].toString()),
                          child: Text(category['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          categoryId = value!;
                        });
                      },
                      validator: (value) =>
                          value == null ? "Category is required" : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? "Quantity is required" : null,
                      onSaved: (value) => quantity = int.parse(value!),
                    ),
                     ElevatedButton(
                      onPressed: pickImage,
                      child: const Text("Pick Image"),
                    ),
                    imgPath.isNotEmpty
                        ? Image.file(File(imgPath), height: 100)
                        : Container(),
                    const SizedBox(height: 20),
                    const Text(
                      "Select Addons",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //create checkbox list
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: addons.length,
                      itemBuilder: (context, index) {
                        final addon = addons[index];
                        final addonId = int.parse(addon['id']
                            .toString()); // Ensure addon ID is an integer
                        return CheckboxListTile(
                          title: Text(addon['name']),
                          value: selectedAddonIds.contains(addonId),
                          onChanged: (bool? value) {
                            toggleAddonSelection(addonId);
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: addProduct,
                      child: const Text("Add Product"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
