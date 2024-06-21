import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static final _firestore = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> getMessages() {
    return _firestore.collection('messages').orderBy('timestamp').snapshots();
  }

  static Future<void> sendMessage(String text, String sender) async {
    await _firestore.collection('messages').add({
      'text': text,
      'sender': sender,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
