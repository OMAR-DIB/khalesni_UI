import 'package:flutter/material.dart';


Route<dynamic> errorRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Use an SVG illustration for a modern look
                // SvgPicture.asset(
                //   'assets/images/error_page.svg', // Ensure the file exists in your assets
                //   height: 150,
                // ),
                const SizedBox(height: 20),
                const Text(
                  "Oops! Page Not Found",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "No route defined for '${settings.name}'.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // CustomButton(
                //   label: "Go Back",
                //   icon: Icons.arrow_back,
                //   onPressed: () => Navigator.pop(_),
                //   padding: const EdgeInsets.symmetric(vertical: 18),
                //   width: 200,
                // ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
