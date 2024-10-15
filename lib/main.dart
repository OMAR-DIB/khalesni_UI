import 'package:flutter/material.dart';
import 'package:gradution_project/controller/theme_provider.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          
        ),
        // ChangeNotifierProvider(
        //   create: (context) => Restaurant(),
          
        // )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: HomeScreen(),
    );
  }
}
