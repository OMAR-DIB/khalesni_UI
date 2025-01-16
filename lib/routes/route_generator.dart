import 'package:flutter/material.dart';
import 'package:gradution_project/controller/payment_provider.dart';
import 'package:gradution_project/routes/app_route.dart';
import 'package:gradution_project/routes/error_route.dart';
import 'package:gradution_project/view/screens/add_new_item.dart';
import 'package:gradution_project/view/screens/admin_screen.dart';
import 'package:gradution_project/view/screens/cart_screen.dart';
import 'package:gradution_project/view/screens/home_screen.dart';
import 'package:gradution_project/view/screens/login_screen.dart';
import 'package:gradution_project/view/screens/order_screen.dart';
import 'package:gradution_project/view/screens/payment_screen.dart';
import 'package:gradution_project/view/screens/register_screen.dart';
import 'package:gradution_project/view/screens/settigns_screen.dart';
import 'package:gradution_project/view/screens/splash_screen.dart';
import 'package:gradution_project/view/screens/where_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoute.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoute.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoute.admin:
        return MaterialPageRoute(builder: (_) => AdminScreen());
      case AppRoute.addNewItem:
        return MaterialPageRoute(builder: (_) => AddNewItem());
      case AppRoute.order:
        return MaterialPageRoute(builder: (_) => OrderScreen());
      case AppRoute.setting:
        return MaterialPageRoute(builder: (_) => SettignsScreen());
      case AppRoute.card:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case AppRoute.payment:
        return MaterialPageRoute(builder: (_) => PaymentScreen());
      case AppRoute.where:
        return MaterialPageRoute(builder: (_) => WhereScreen());
    }
    return errorRoute(settings);
  }
}
