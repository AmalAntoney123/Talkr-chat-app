// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:talkr/services/auth/auth_service.dart';
import 'package:talkr/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerTheme:
                      const DividerThemeData(color: Colors.transparent),
                ),
                child: DrawerHeader(
                    child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("Home"),
                  leading: Icon(Icons.home),
                  iconColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.primary,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                    title: Text("Settings"),
                    leading: Icon(Icons.settings),
                    iconColor: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.primary,
                    onTap: () => {
                          Navigator.pop(context),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()))
                        }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              iconColor: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.primary,
              onTap: () => {Navigator.pop(context), logout()},
            ),
          ),
        ],
      ),
    );
  }
}
