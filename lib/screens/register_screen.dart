import 'package:flutter/material.dart';
import 'package:gradution_project/widgets/my_button.dart';
import 'package:gradution_project/widgets/my_textField.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmePasswordController = TextEditingController();
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
          const SizedBox(
            height: 20,
          ),
          const Text("Let's create an account"),
          const SizedBox(
            height: 20,
          ),
          MyTextField(hintText: "email", controller: emailController),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            hintText: "Password",
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            hintText: "confirm Password",
            controller: confirmePasswordController,
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          MyButton(text: "Register", onTap: (){},width: 119,color: Theme.of(context).colorScheme.onSecondary,),
          const SizedBox(
            height: 20,
          ),
          MyButton(text: "Login", onTap: (){},width: 119,color: Theme.of(context).colorScheme.onSecondary,),
        ],
      ),
    );
  }
}