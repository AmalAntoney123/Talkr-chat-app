// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talkr/components/chat_bubble.dart';
import 'package:talkr/components/my_textfield.dart';
import 'package:talkr/services/auth/auth_service.dart';
import 'package:talkr/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String recieverID;
  ChatPage({super.key, required this.recieverEmail, required this.recieverID});

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(recieverID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput()
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getUserEmail()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(recieverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCUrrentUser = data['senderID'] == _authService.getUserEmail()!.uid;

    var alignment =
        isCUrrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: ChatBubble(
          isCurrentUser: isCUrrentUser,
          message: data["message"],
        ));
  }

  Widget _buildUserInput() {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: MyTextField(
                  hintText: "Type a Message",
                  obscureText: false,
                  textEditingController: _messageController),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: IconButton(
                  onPressed: sendMessage,
                  icon: Icon(Icons.send),
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
