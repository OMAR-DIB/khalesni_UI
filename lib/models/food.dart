class Food {
  final String name;
  final double price;
  final String description;
  final String imagePath;
  final FoodCategory category;
  List<Addon> availableAddon;
  
  Food(
      {required this.name,
      required this.price,
      required this.description,
      required this.imagePath,
      required this.category,
      required this.availableAddon});
}

enum FoodCategory {
  burgers,
  drinks,
  salads,
  sides,
  desserts,
}

class Addon {
  String name;
  double price;

  Addon({required this.name, required this.price});
}
