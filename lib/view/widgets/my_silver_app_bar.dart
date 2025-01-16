import 'package:flutter/material.dart';
import 'package:gradution_project/routes/app_route.dart';
import 'package:gradution_project/view/screens/cart_screen.dart';

class MySilverAppBar extends StatelessWidget {
  final Widget child;

  const MySilverAppBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SliverAppBar(
      expandedHeight: 227,
      collapsedHeight: 227,
      floating: false,
      pinned: true,
      actions: [
        IconButton(
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const CartScreen(),
            //   ),
            // );
            Navigator.pushNamed(context, AppRoute.card);
          },
          style: ButtonStyle(
                // iconSize: WidgetStateProperty.all<double>(12),
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.orange[300]!),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        13.0), // Set to 0.0 for rectangular shape
                  ),  
                ),
              ),
          icon: const Icon(
            Icons.shopping_cart,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text(
        "Sunset Dinner",
        style: TextStyle(fontSize: 20),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.only(
            bottom: screenHeight * 0.06,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
          ),
          child: child,
        ),
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
