import 'package:flutter/material.dart';
import 'package:gradution_project/controller/switch_login_controller.dart';
import 'package:gradution_project/view/screens/admin_screen.dart';
import 'package:gradution_project/view/screens/home_screen.dart';
import 'package:gradution_project/view/widgets/my_button.dart';
import 'package:gradution_project/view/widgets/my_text_field.dart';
import 'package:gradution_project/controller/user_controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final userService = UserService();

    void login() async {
      try {
        final response = await userService.loginUser(
          emailController.text,
          passwordController.text,
        );

        if (response['status'] == 'success') {
          final role = response['user']['role'];
          emailController.clear();
          passwordController.clear();   
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful')),
          );

          if (role == 'admin') {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      const AdminScreen()), // Navigate to AdminScreen
            );
          } else if (role == 'customer') {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      const HomeScreen()), // Navigate to HomeScreen
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'])),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_open_rounded,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text("Food Delivery App"),
          const SizedBox(height: 20),
          MyTextField(hintText: "Email", controller: emailController),
          const SizedBox(height: 20),
          MyTextField(
              hintText: "Password",
              controller: passwordController,
              obscureText: true),
          const SizedBox(height: 20),
          MyButton(
            text: "Login",
            onTap: login,
            width: 119,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('don\'t have an account?'),
              TextButton(
                onPressed: () {
                  context.read<SwitchLoginController>().toggleLog();
                },
                child: Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
