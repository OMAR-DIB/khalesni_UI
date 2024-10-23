import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/view/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class AddOnProvider extends ChangeNotifier {
  final Map<Addon, bool> selectedAddons = {};

  void initializeAddons(List<Addon> addons) {
    for (var addon in addons) {
      selectedAddons[addon] = false;
    }
    notifyListeners();
  }

  void toggleAddon(Addon addon) {
    selectedAddons[addon] = !selectedAddons[addon]!;
    notifyListeners();
  }

  List<Addon> get selected => selectedAddons.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();

  void addItemToCart(Food food,Map<Addon, bool> selectedAddons,BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartScreen()));
    List<Addon> currentlySelectors = [];
    for (Addon addon in food.availableAddon){
      if (selectedAddons[addon] == true){
        currentlySelectors.add(addon);
      }
    }
    context.read<Restaurant>().addToCart(food, currentlySelectors);
  }
  
}