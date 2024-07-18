// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            )
          ],
        ),
      ),
    );
  }
}
