import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradution_project/models/cart_item.dart';
import 'package:gradution_project/models/food.dart';
import 'package:gradution_project/view/widgets/my_food_tile.dart';

class Restaurant extends ChangeNotifier {
  // burger
  final List<Food> _menu = [
    // burger
    Food(
      name: "classic burger",
      price: 0.99,
      description:
          "A juicy beef with melted cheder, lettuce, tomato,and hint of union and pickle",
      imagePath: "assets/burger/burger-2.jpg",
      category: FoodCategory.burgers,
      availableAddon: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 3.00),
      ],
    ),
    Food(
      name: "classic burger",
      price: 0.99,
      description:
          "A juicy beef with melted cheder, lettuce, tomato,and hint of union and pickle",
      imagePath: "assets/burger/burger-1.jpg",
      category: FoodCategory.burgers,
      availableAddon: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Avocado", price: 3.00),
      ],
    ),
    Food(
      name: "classic burger",
      price: 0.99,
      description:
          "A juicy beef with melted cheder, lettuce, tomato,and hint of union and pickle",
      imagePath: "assets/burger/burger-3.jpg",
      category: FoodCategory.burgers,
      availableAddon: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 3.00),
      ],
    ),
    Food(
      name: "classic burger",
      price: 0.99,
      description:
          "A juicy beef with melted cheder, lettuce, tomato,and hint of union and pickle",
      imagePath: "assets/burger/burger-4.jpg",
      category: FoodCategory.burgers,
      availableAddon: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 3.00),
      ],
    ),
    Food(
      name: "classic burger",
      price: 0.99,
      description:
          "A juicy beef with melted cheder, lettuce, tomato,and hint of union and pickle",
      imagePath: "assets/burger/burger-5.jpg",
      category: FoodCategory.burgers,
      availableAddon: [
        Addon(name: "Avocado", price: 3.00),
      ],
    ),

// drinks
    Food(
      name: "Coffe",
      price: 0.99,
      description: "Turkish Coffe",
      imagePath: "assets/drinks/drink-1.jpg",
      category: FoodCategory.drinks,
      availableAddon: [
        Addon(name: "classic Coffe", price: 0.99),
      ],
    ),
    Food(
      name: "Water",
      price: 0.99,
      description: "Bottle of Tanourine",
      imagePath: "assets/drinks/drink-2.jpg",
      category: FoodCategory.drinks,
      availableAddon: [
        Addon(name: "classic Water", price: 0.99),
      ],
    ),
    Food(
      name: "Tea",
      price: 0.99,
      description: "Syrian Tea",
      imagePath: "assets/drinks/drink-3.jpg",
      category: FoodCategory.drinks,
      availableAddon: [
        Addon(name: "classic Tea", price: 0.99),
      ],
    ),
    Food(
      name: "Lemon Mint",
      price: 0.99,
      description: "Lemon,water, and ice",
      imagePath: "assets/drinks/drink-4.jpg",
      category: FoodCategory.drinks,
      availableAddon: [
        Addon(name: "classic Lemon", price: 0.99),
      ],
    ),
    Food(
      name: "Zee Cola",
      price: 0.99,
      description: "instead of coca-cola",
      imagePath: "assets/drinks/drink-5.jpg",
      category: FoodCategory.drinks,
      availableAddon: [
        Addon(name: "classic zee-Cola", price: 0.99),
      ],
    ),

// salads
    Food(
      name: "Caesar Salad",
      price: 0.99,
      description:
          "A classic salad featuring romaine lettuce, croutons, Parmesan cheese.",
      imagePath: "assets/salads/salad-1.jpg",
      category: FoodCategory.salads,
      availableAddon: [
        Addon(name: "classic Caesar Salad", price: 0.99),
      ],
    ),
    Food(
      name: "Greek Salad",
      price: 0.99,
      description:
          "A flavorful salad made with tomatoes, cucumbers, red onion, feta cheese.",
      imagePath: "assets/salads/salad-2.jpg",
      category: FoodCategory.salads,
      availableAddon: [
        Addon(name: "classic Greek Salad", price: 0.99),
      ],
    ),
    Food(
      name: "Cobb Salad",
      price: 0.99,
      description:
          "A hearty salad with mixed greens, grilled chicken, bacon, eggs, avocado, tomatoes.",
      imagePath: "assets/salads/salad-3.jpg",
      category: FoodCategory.salads,
      availableAddon: [
        Addon(name: "classic Cobb Salad", price: 0.99),
      ],
    ),
    Food(
      name: "Caprese Salad",
      price: 0.99,
      description:
          "A simple yet elegant salad made with fresh mozzarella, tomatoes, basil.",
      imagePath: "assets/salads/salad-4.jpg",
      category: FoodCategory.salads,
      availableAddon: [
        Addon(name: "classic Caprese Salad", price: 0.99),
      ],
    ),
    Food(
      name: "Tuna Salad",
      price: 0.99,
      description:
          "A protein-packed salad made with canned tuna, mayonnaise, celery, onion.",
      imagePath: "assets/salads/salad-5.jpg",
      category: FoodCategory.salads,
      availableAddon: [
        Addon(name: "classic Tuna Salad", price: 0.99),
      ],
    ),

// sides
    Food(
      name: "French Fries",
      price: 0.99,
      description:
          "Crispy, golden-brown strips of potato, often served with ketchup.",
      imagePath: "assets/sides/side-1.jpg",
      category: FoodCategory.sides,
      availableAddon: [
        Addon(name: "classic French Fries", price: 0.99),
      ],
    ),
    Food(
      name: "tabbouleh",
      price: 0.99,
      description: "Lebanese salad made with bulgur wheat, parsley, tomatoes.",
      imagePath: "assets/sides/side-2.jpg",
      category: FoodCategory.sides,
      availableAddon: [
        Addon(name: "classic tabbouleh", price: 0.99),
      ],
    ),
    Food(
      name: "Mashed Potatoes",
      price: 0.99,
      description: " Creamy, smooth potatoes that have been boiled, mashed.",
      imagePath: "assets/sides/side-3.jpg",
      category: FoodCategory.sides,
      availableAddon: [
        Addon(name: "classic Mashed Potatoes", price: 0.99),
      ],
    ),
    Food(
      name: "Rice",
      price: 0.99,
      description: "A versatile grain that can be cooked in various ways.",
      imagePath: "assets/sides/side-4.jpg",
      category: FoodCategory.sides,
      availableAddon: [
        Addon(name: "classic Rice", price: 0.99),
      ],
    ),
    Food(
      name: "Mac and Cheese",
      price: 0.99,
      description:
          "A comforting dish made with macaroni pasta mixed with a creamy cheese sauce.",
      imagePath: "assets/sides/side-5.jpg",
      category: FoodCategory.sides,
      availableAddon: [
        Addon(name: "classic Rice", price: 0.99),
      ],
    ),

// desserts
    Food(
      name: "Ice Cream",
      price: 0.99,
      description:
          "A frozen dessert made from cream, milk, sugar, and flavorings.",
      imagePath: "assets/desserts/dessert-1.jpg",
      category: FoodCategory.desserts,
      availableAddon: [
        Addon(name: "classic Ice Cream", price: 0.99),
      ],
    ),
    Food(
      name: "Chocolate Cake",
      price: 0.99,
      description: "A decadent dessert made with a rich chocolate batter.",
      imagePath: "assets/desserts/dessert-2.jpg",
      category: FoodCategory.desserts,
      availableAddon: [
        Addon(name: "classic Chocolate Cake", price: 0.99),
      ],
    ),
    Food(
      name: "Apple Pie",
      price: 0.99,
      description:
          "A classic American dessert, apple pie consists of a flaky crust filled with a sweet apple filling.",
      imagePath: "assets/desserts/dessert-3.jpg",
      category: FoodCategory.desserts,
      availableAddon: [
        Addon(name: "classic Apple Pie", price: 0.99),
      ],
    ),
    Food(
      name: "Tiramisu",
      price: 0.99,
      description: "An Italian dessert made with ladyfingers dipped in coffee.",
      imagePath: "assets/desserts/dessert-4.jpg",
      category: FoodCategory.desserts,
      availableAddon: [
        Addon(name: "classic Tiramisu", price: 0.99),
      ],
    ),
    Food(
      name: "Cheesecake",
      price: 0.99,
      description:
          "A creamy dessert made with cream cheese, sugar, eggs, and flavorings.",
      imagePath: "assets/desserts/dessert-5.jpg",
      category: FoodCategory.desserts,
      availableAddon: [
        Addon(name: "Cheesecake", price: 0.99),
      ],
    ),
  ];

  List<Food> get menu => _menu;

  List<Food> filterMenuByCategories(
      FoodCategory catregory, List<Food> fullMenu) {
    return fullMenu.where((element) => element.category == catregory).toList();
  }

  List<Widget> getFiltredFood(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = filterMenuByCategories(category, fullMenu);
      return ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) =>
              MyFoodTile(food: categoryMenu[index], onTap: () {}));
    }).toList();
  }

  //  OPERATRIONS

  // add to cart
  List<CartItem> _cart = [];
  List<CartItem> get cart => _cart;
  void addToCart(Food food, List<Addon> selectedAddons) {
    // Helper function to compare two lists of Addon objects
    bool _areAddonsSame(List<Addon> list1, List<Addon> list2) {
      if (list1.length != list2.length) return false;
      for (int i = 0; i < list1.length; i++) {
        if (list1[i] != list2[i]) return false;
      }
      return true;
    }
    // Function to find matching cart item
    CartItem? _findCartItem(Food food, List<Addon> selectedAddons) {
      for (var item in _cart) {
        if (item.food == food &&
            _areAddonsSame(item.selectedAddons, selectedAddons)) {
          return item;
        }
      }
      return null;
    }
    // Find the item in the cart
    CartItem? cartItem = _findCartItem(food, selectedAddons);
    // If item exists, increase quantity, otherwise add new item
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem){
    int index = _cart.indexOf(cartItem);
    if (index != -1){
      if(_cart[index].quantity > 1){
        cartItem.quantity--;
      }
      else {
        _cart.removeAt(index);
      }
    }
    notifyListeners(); 
  }
  // get total price of cart
  double getTotalPrice(){
    double totaL = 0.0;
    for (CartItem cartItem in _cart){
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddons){
        itemTotal += addon.price;
      }
      totaL = itemTotal * cartItem.quantity;
    }
    return totaL;
  }
  // get total nb of items in cart
  int getNbOfItemInCart(){
    return _cart.length;
  }
  // clear the cart
  void clearCart(){
    _cart.clear();
    notifyListeners();
  }
  /* HELPERS
  // generate a receip
  // format double value into money
  // format list of addons into a string summary
   
  
  */
}
