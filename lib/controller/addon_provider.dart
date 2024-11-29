import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:provider/provider.dart';

class AddOnProvider extends ChangeNotifier {
  final Map<Addones, bool> selectedAddons = {};

  void initializeAddons(List<Addones> addons) {
    for (var addon in addons) {
      selectedAddons[addon] = false;
    }
    notifyListeners();
  }

  void toggleAddon(Addones addon) {
    selectedAddons[addon] = !selectedAddons[addon]!;
    notifyListeners();
  }

  List<Addones> get selected => selectedAddons.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();

  void addItemToCart(Food food,Map<Addones, bool> selectedAddons,BuildContext context){
    Navigator.of(context).pop();
    List<Addones> currentlySelectors = [];
    for (Addones addon in food.addons){
      if (selectedAddons[addon] == true){
        currentlySelectors.add(addon);
      }
    }
    context.read<Restaurant>().addToCart(food, currentlySelectors);
  }
  
}