import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAddons();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/khalesni/api/getAllCategory.php'));
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
      _showErrorSnackBar('Error: $e');
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
      _showErrorSnackBar('Error picking image: $e');
    }
  }

  Future<void> fetchAddons() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/khalesni/api/getAllAddones.php'));
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
      _showErrorSnackBar('Error: $e');
    }
  }

  Future<void> addProduct() async {
    if (!_formKey.currentState!.validate()) return;

    // Validate additional fields
    if (imgPath.isEmpty) {
      _showErrorSnackBar('Image is required');
      return;
    }
    if (categoryId == 0) {
      _showErrorSnackBar('Please select a category');
      return;
    }

    // Fetch values from TextEditingControllers
    final name = nameController.text.trim();
    final price = double.tryParse(priceController.text) ?? 0.0;
    final description = descriptionController.text.trim();
    final quantity = int.tryParse(quantityController.text) ?? 0;

    // Prepare the product data
    final productData = {
      "name": name,
      "price": price,
      "description": description,
      "category_id": categoryId,
      "imgPath": imgPath,
      "quantity": quantity,
      "addons": selectedAddonIds.isEmpty ? [] : selectedAddonIds,
    };

    // Log the productData to debug if needed
    print('Product Data: ${json.encode(productData)}');

    try {
      final response = await http.post(
        Uri.parse('http://localhost/khalesni/api/addNewProduct.php'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(productData),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        _showSuccessSnackBar('Product added successfully!');
        _resetForm();
      } else {
        final errorMessage = responseData['message'] ?? "Failed to add product. Please try again.";
        _showErrorSnackBar('Error Message: $errorMessage');
      }
    } catch (e) {
      _showErrorSnackBar('Error: $e');
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    quantityController.clear();
    setState(() {
      imgPath = '';
      categoryId = 0;
      selectedAddonIds.clear();
    });
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
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => value!.isEmpty ? "Name is required" : null,
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? "Price is required" : null,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(labelText: 'Description'),
                      validator: (value) => value!.isEmpty ? "Description is required" : null,
                    ),
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(labelText: 'Category'),
                      value: categoryId != 0 ? categoryId : null,
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
                      validator: (value) => value == 0 ? "Category is required" : null,
                    ),
                    TextFormField(
                      controller: quantityController,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? "Quantity is required" : null,
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: addons.length,
                      itemBuilder: (context, index) {
                        final addon = addons[index];
                        final addonId = int.parse(addon['id'].toString());
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