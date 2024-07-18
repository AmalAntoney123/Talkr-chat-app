// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:talkr/services/auth/auth_service.dart';
import 'package:talkr/components/my_button.dart';
import 'package:talkr/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 50,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 50),
              Text(
                "Welcome Back",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
              SizedBox(height: 25),
              MyTextField(
                hintText: "Email",
                obscureText: false,
                textEditingController: _emailController,
              ),
              SizedBox(height: 10),
              MyTextField(
                hintText: "Password",
                obscureText: true,
                textEditingController: _passwordController,
              ),
              SizedBox(height: 10),
              MyButton(
                ButtonText: "Login",
                onTap: () => login(context),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text("Register now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
