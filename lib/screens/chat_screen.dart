import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';




class ChatController extends GetxController {
  var messages = <Map<String, dynamic>>[].obs;
  var showEmojiPicker = false.obs;

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      messages.add({'type': 'text', 'content': text});
    }
  }

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        messages.add({'type': 'image', 'content': pickedFile.path});
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void toggleEmojiPicker() {
    showEmojiPicker.value = !showEmojiPicker.value;
  }
}

class ChatScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  ChatScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    // Use userData to display user information or pass it down to child widgets
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Data:'),
            Text('Name: ${userData["name"]}'),
            Text('Email: ${userData["email"]}'),
            // Display more user information as needed
          ],
        ),
      ),
    );
  }
}