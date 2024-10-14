import 'package:flutter/material.dart';
import 'package:gradution_project/view/screens/settigns_screen.dart';
import 'package:gradution_project/view/widgets/my_drawer_title.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              MyDrawerTitle(
                text: 'Home',
                icon: Icons.home,
                onTap: () {
                  // Navigate to Home Page
                  // Navigator.of(context).pushReplacementNamed('/home');
                  Navigator.of(context).pop();
                },
              ),
              MyDrawerTitle(
                text: 'Settings',
                icon: Icons.settings,
                onTap: () {
                  // Navigate to Settings Page
                  // Navigator.of(context).pushReplacementNamed('/settings');
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettignsScreen(),),);
                },
              ),
            ],
          ),
          // Log out button at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: MyDrawerTitle(
              text: 'Log Out',
              icon: Icons.logout,
              onTap: () {
                // Perform log out operation here
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
