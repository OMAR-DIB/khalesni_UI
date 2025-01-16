import 'package:flutter/material.dart';
import 'package:gradution_project/controller/switch_login_controller.dart';
import 'package:gradution_project/routes/app_route.dart';
import 'package:gradution_project/view/screens/login_screen.dart';
import 'package:gradution_project/view/widgets/my_button.dart';
import 'package:gradution_project/view/widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import 'package:gradution_project/controller/user_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final userService = UserService();

    void register() async {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      try {
        final response = await userService.registerUser(
          emailController.text,
          passwordController.text,
          usernameController.text,
        );

        if (response['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration successful')),
          );
          Navigator.pushReplacementNamed(context, AppRoute.login);
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
          const Icon(
            Icons.lock_open_rounded,
            color: Color.fromARGB(255, 155, 108, 33),
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            "Let's create an account",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          MyTextField(hintText: "Username", controller: usernameController),
          const SizedBox(height: 20),
          MyTextField(hintText: "Email", controller: emailController),
          const SizedBox(height: 20),
          MyTextField(
              hintText: "Password",
              controller: passwordController,
              obscureText: true),
          const SizedBox(height: 20),
          MyTextField(
              hintText: "Confirm Password",
              controller: confirmPasswordController,
              obscureText: true),
          const SizedBox(height: 20),
          MyButton(
            text: "Register",
            onTap: register,
            width: 119,
            color: const Color.fromARGB(255, 155, 108, 33),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'have an account?',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              TextButton(
                onPressed: () {
                  context.read<SwitchLoginController>().toggleLog();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color.fromARGB(255, 237, 161, 40),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
