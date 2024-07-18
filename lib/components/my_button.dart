// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  void Function()? onTap;
  final String ButtonText;
  MyButton({super.key, required this.ButtonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(25),
        child: Center(
            child: Text(
          ButtonText,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        )),
      ),
    );
  }
}
