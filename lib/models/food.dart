enum FoodCategory {
    burgers,
    drinks,
    salads,
    sides,
    desserts,
}
  
class Food {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imgPath;
  final String categoryId;
  final String categoryName;
  final int quantity;
  final List<Addones> addons;

  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imgPath,
    required this.categoryId,
    required this.categoryName,
    required this.quantity,
    required this.addons,
  });

  // Factory method to parse JSON into a Food object
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
      description: json['description'],
      imgPath: json['imgPath'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      quantity: int.parse(json['quantity']),
      addons: (json['addons'] as List)
          .map((addonJson) => Addones.fromJson(addonJson))
          .toList(),
    );
  }
}

class Addones {
  final String id;
  final String name;
  final double price;

  Addones({
    required this.id,
    required this.name,
    required this.price,
  });

  // Factory method to parse JSON into an Addon object
  factory Addones.fromJson(Map<String, dynamic> json) {
    return Addones(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
    );
  }
}

  // class Food {
  //   final String name;
  //   final double price;
  //   final String description;
  //   final String imagePath;
  //   final FoodCategory category;
  //   List<Addon> availableAddon;
    
  //   Food(
  //       {required this.name,
  //       required this.price,
  //       required this.description,
  //       required this.imagePath,
  //       required this.category,
  //       required this.availableAddon});
  // }

  // class Addon {
  //   String name;
  //   double price;

  //   Addon({required this.name, required this.price});
  // }
