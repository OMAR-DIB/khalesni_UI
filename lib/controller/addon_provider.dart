import 'package:flutter/material.dart';
import 'package:gradution_project/models/food.dart';

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
}