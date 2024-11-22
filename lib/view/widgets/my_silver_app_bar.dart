import 'package:flutter/material.dart';
import 'package:gradution_project/view/screens/cart_screen.dart';

class MySilverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const MySilverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SliverAppBar(
      expandedHeight: screenHeight * 0.44, // Set a reasonable expanded height
      collapsedHeight: screenHeight * 0.12, // Fixed collapsed height
      floating: false, // Not floating to avoid layout jumps
      pinned: true, // Keeps the app bar pinned when scrolling
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
          icon: Icon(Icons.shopping_cart,size: screenHeight * 0.06,),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title:  Text("Sunset Dinner",
      style: TextStyle(
        fontSize: screenHeight * 0.038,
      ),),
      // title: title, // Use the passed title widget
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.only(
            bottom: screenHeight * 0.06,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
          ),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        expandedTitleScale: 1.2, // Slightly enlarge the title in expanded state
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:gradution_project/view/screens/cart_screen.dart';

// class MySilverAppBar extends StatelessWidget {
//   final Widget child;
//   final Widget title;
//   const MySilverAppBar({super.key, required this.child, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return SliverAppBar(
//       // expandedHeight: screenWidth * 0.55, // Adjusted for responsiveness
//       // collapsedHeight: screenWidth * 0.15, // Dynamic height
//       expandedHeight: screenWidth * 0.6,
//       collapsedHeight: screenHeight * 0.15,
//       floating: true,
//       pinned: true,
//       actions: [
//         IconButton(onPressed: () {

//           Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartScreen(),),);
//         }, icon: const Icon(Icons.shopping_cart))
//       ],
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       foregroundColor: Theme.of(context).colorScheme.inversePrimary,
//       title:  Text("Sunset Dinner",
//       style: TextStyle(
//         fontSize: screenHeight * 0.03,
//       ),),
//       flexibleSpace: FlexibleSpaceBar(
//         background: Padding(
//           padding:  EdgeInsets.only(bottom:  screenWidth * 0.08),
//           child: child,
//         ),
//         title: title,
//         expandedTitleScale: 1,
//         centerTitle: true,
//         titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
//       ),
//     );
//   }
// }
