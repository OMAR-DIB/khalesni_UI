import 'package:flutter/material.dart';
import 'package:gradution_project/controller/switch_login_controller.dart';
import 'package:gradution_project/view/screens/login_screen.dart';
import 'package:gradution_project/view/screens/register_screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SwitchLoginController(),
      child: Builder(
        builder: (context) {
          final isLogin = context.watch<SwitchLoginController>().isLogin;
          return isLogin ? const LoginScreen() : const RegisterScreen();
        },
      ),
    );
  }
}
