import 'package:flutter/material.dart';
import 'package:gradution_project/view/screens/cart_screen.dart';

class MySilverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  const MySilverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      collapsedHeight: 120,
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
          padding: const EdgeInsets.only(bottom: 58.0),
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
