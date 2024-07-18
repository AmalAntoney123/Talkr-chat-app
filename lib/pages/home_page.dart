// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:talkr/components/my_drawer.dart';
import 'package:talkr/components/user_tile.dart';
import 'package:talkr/pages/chat_page.dart';
import 'package:talkr/services/auth/auth_service.dart';
import 'package:talkr/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Talkr",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.getUserEmail()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        recieverEmail: userData['email'],
                        recieverID: userData['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
