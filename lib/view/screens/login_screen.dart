import 'package:flutter/material.dart';
import 'package:gradution_project/controller/switch_login_controller.dart';
import 'package:gradution_project/main.dart';
import 'package:gradution_project/models/restaurant.dart';
import 'package:gradution_project/routes/app_route.dart';
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

    void login(String email, String pass) async {
      try {
        final response = await userService.loginUser(
          emailController.text,
          passwordController.text,
        );

        if (response['status'] == 'success') {
          final role = response['user']['role'];
          shared.setInt('id', response['user']['id']);
          shared.setString('name', response['user']['username']);
          emailController.clear();
          passwordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful')),
          );

          if (role == 'admin') {
          
          
            Navigator.pushReplacementNamed(context, AppRoute.admin);
          } else if (role == 'customer') {
             Navigator.pushReplacementNamed(context, AppRoute.home);
                      
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

    return ChangeNotifierProvider(
        create: (context) => Restaurant(),
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_open_rounded,
                  color:  Color.fromARGB(255, 155, 108, 33),
                  size: 100,
                ),
                const SizedBox(height: 20),
                const Text("Khalesni App",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
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
                  onTap: () {
                    login(emailController.text, passwordController.text);
                  },
                  width: 119,
                  color: const Color.fromARGB(255, 155, 108, 33),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('don\'t have an account?',style: TextStyle(fontWeight: FontWeight.w900),),
                    TextButton(
                      onPressed: () {
                        context.read<SwitchLoginController>().toggleLog();
                      },
                      child: const Text('Register',style: TextStyle(color:  Color.fromARGB(255, 237, 161, 40),),),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
