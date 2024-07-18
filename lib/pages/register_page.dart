// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:talkr/services/auth/auth_service.dart';
import 'package:talkr/components/my_button.dart';
import 'package:talkr/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  void register(context) async {
    final authService = AuthService();

    try {
      if (_passwordController.text == _cpasswordController.text) {
        await authService.signUpWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Passwords dont match!"),
          ),
        );
      }
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
  RegisterPage({super.key, required this.onTap});

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
                "Let's create an account for you",
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
              MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                textEditingController: _cpasswordController,
              ),
              SizedBox(height: 10),
              MyButton(
                ButtonText: "Register",
                onTap: () => register(context),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text("Login here",
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
