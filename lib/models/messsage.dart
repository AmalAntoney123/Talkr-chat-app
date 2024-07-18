import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String recieverID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.message,
    required this.senderID,
    required this.senderEmail,
    required this.recieverID,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'Timestamp': timestamp,
      'RecieverID': recieverID,
      'message': message
    };
  }
}
