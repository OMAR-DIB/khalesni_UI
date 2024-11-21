import 'package:flutter/material.dart';
import 'package:gradution_project/view/screens/cart_screen.dart';

class MySilverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  const MySilverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SliverAppBar(
      expandedHeight: screenHeight * 0.6, // Adjusted for responsiveness
      collapsedHeight: screenHeight * 0.15, // Dynamic height
      floating: false,
      pinned: true,
      actions: [
        IconButton(onPressed: () {

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartScreen(),),);
        }, icon: const Icon(Icons.shopping_cart))
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Sunset Dinner"),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding:  EdgeInsets.only(bottom:  screenWidth * 0.08),
          child: child,
        ),
        title: title,
        expandedTitleScale: 1,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
      ),
    );
  }
}
