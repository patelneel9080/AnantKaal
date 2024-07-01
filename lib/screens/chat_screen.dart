import 'dart:convert';
import 'dart:io';
import 'package:anantkaal/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../utils/constant/const_color.dart';

class ChatScreen extends StatefulWidget {
  String fullName;

  ChatScreen({required this.fullName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List _messages = [];
  String userId = "119"; // Example user ID
  String authToken = "2ec26ad9-e039-445e-915e-zACl56sr2q";
  ScrollController _scrollController = ScrollController();
  bool _showEmojiPicker = false; // Track whether to show emoji picker

  @override
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _getMessages();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        _showEmojiPicker =
        false; // Hide emoji picker when normal keyboard opens
      });
    }
  }

  void _handleEmojiSelected(String emoji) {
    setState(() {
      _showEmojiPicker = true; // Keep emoji picker open after selection
    });
    _controller.text += emoji;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    ); // Move cursor to end of text
  }
  Future<void> _sendMessage(String message, {File? imageFile}) async {
    final url = Uri.parse('https://api.baii.me/api/createglobalchat');
    final headers = {
      'Content-Type': 'application/json',
      'AuthToken': '$authToken',
    };

    // Prepare the body of the request
    Map<String, dynamic> body = {
      'user_id': userId,
      'message': message,
    };

    // If an image file is provided, encode it to base64 and add to the body
    if (imageFile != null) {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      body['image'] = base64Image;
    }

    final encodedBody = jsonEncode(body);

    print('Sending message: $encodedBody');

    final response = await http.post(url, headers: headers, body: encodedBody);

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      _controller.clear();
      _getMessages();
    } else {
      print('Failed to send message: ${response.body}');
    }
  }

  Future<void> _getMessages() async {
    final url = Uri.parse('https://api.baii.me/api/showglobalchat');
    final headers = {
      'AuthToken': '$authToken',
    };

    print('Fetching messages...');

    final response = await http.get(url, headers: headers);

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      setState(() {
        _messages = jsonDecode(response.body)['data'] ?? [];
      });
      _scrollToBottom();
    } else {
      print('Failed to fetch messages: ${response.body}');
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  Future<void> _handleImagePick() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await _sendMessage('', imageFile: imageFile); // Pass imageFile to _sendMessage
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height / 14),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.active_Textfild_color,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Group Chat",
                    style: GoogleFonts.cherrySwash(
                        textStyle: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
                Text(
                widget.fullName,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.text_color,
                    fontFamily: 'Exo', // Update with your font if needed
                  ),
                ),
              ],
            ),
            actions: [
              PopupMenuButton(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset(AppIcons.flute),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Log out"),
                      onTap: () {
                        Get.to(() => SplashScreen());
                      },
                    )
                  ];
                },
              ) // Replace with your image asset path
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                child: Text(
                  'No messages yet.',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var chatDetails = _messages[index]['Chat_details'];
                  var userDetails = _messages[index]['user_details'];
                  var messageTime = _messages[index]['timestamp'] as String?; // Ensure messageTime is nullable

                  if (userDetails != null && userDetails.isNotEmpty) {
                    var user = userDetails[0];

                    // Format message timestamp if available
                    String formattedTime = '';
                    if (messageTime != null && messageTime.isNotEmpty) {
                      DateTime parsedTime = DateTime.tryParse(messageTime) ?? DateTime.now();
                      formattedTime = DateFormat.Hm().format(parsedTime);
                    } else {
                      formattedTime = ''; // Handle case where timestamp is empty or null
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            user['name'] ?? "",
                            style: GoogleFonts.exo(
                              textStyle: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          subtitle: formattedTime.isNotEmpty
                              ? Text(
                            formattedTime,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          )
                              : SizedBox.shrink(), // Display nothing if formattedTime is empty
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xffDDEFF0),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.zero,
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            chatDetails['message'] ?? "",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
            Column(
              children: [
                Divider(
                  color: kPrimaryColor,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColor.Textfild_color,
                            borderRadius:
                            BorderRadius.circular(Get.width / 50),
                            border: Border.all(
                              color: AppColor.active_Textfild_color,
                            ),
                          ),
                          child: TextField(
                            controller: _controller,
                            focusNode:
                            _focusNode, // Attach focus node to TextField
                            decoration: InputDecoration(
                              hintText: "Enter message",
                              hintStyle: TextStyle(
                                color: AppColor.active_Textfild_color,
                              ),
                              contentPadding: EdgeInsets.all(10),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: toggleEmojiPicker,
                                  child: Image.asset(AppIcons.Vector),
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                  child: GestureDetector(
                                  onTap: _handleImagePick,
                                  child: Image.asset(AppIcons.photo),
                                ),
                              ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Adjust spacing between TextField and IconButton
                      GestureDetector(
                        onTap: () {
                          if (_controller.text.isNotEmpty) {
                            _sendMessage(_controller.text);
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColor.active_Textfild_color,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColor.active_Textfild_color,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                                AppIcons.Sent), // Replace with your image asset path
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showEmojiPicker)
                  Container(
                    height: 250,
                    child: EmojiPickerWidget(
                      onEmojiSelected: _handleEmojiSelected,
                    ),
                  ),
              ],
            ),
          ],
        ),
    );
  }
}

class EmojiPickerWidget extends StatelessWidget {
  final Function(String) onEmojiSelected;

  EmojiPickerWidget({Key? key, required this.onEmojiSelected})
      : super(key: key);

  final List<String> emojis = [
    "😀",
    "😃",
    "😄",
    "😁",
    "😆",
    "😅",
    "🤣",
    "😂",
    "🙂",
    "🙃",
    "😉",
    "😊",
    "😇",
    "🥰",
    "😍",
    "🤩",
    "😘",
    "😗",
    "😚",
    "😙",
    "😋",
    "😛",
    "😜",
    "🤪",
    "😝",
    "🤑",
    "🤗",
    "🤭",
    "🤫",
    "🤔",
    "🤐",
    "🤨",
    "😐",
    "😑",
    "😶",
    "😏",
    "😒",
    "🙄",
    "😬",
    "🤥",
    "😌",
    "😔",
    "😪",
    "🤤",
    "😴",
    "😷",
    "🤒",
    "🤕",
    "🤢",
    "🤮",
    "🤧",
    "🥵",
    "🥶",
    "🥴",
    "😵",
    "🤯",
    "🤠",
    "🥳",
    "😎",
    "🤓",
    "🧐",
    "😕",
    "😟",
    "🙁",
    "☹️",
    "😮",
    "😯",
    "😲",
    "😳",
    "🥺",
    "😦",
    "😧",
    "😨",
    "😰",
    "😥",
    "😢",
    "😭",
    "😱",
    "😖",
    "😣",
    "😞",
    "😓",
    "😩",
    "😫",
    "🥱",
    "😤",
    "😡",
    "😠",
    "🤬",
    "😈",
    "👿",
    "💀",
    "☠️",
    "💩",
    "🤡",
    "👹",
    "👺",
    "👻",
    "👽",
    "👾",
    "🤖",
    "😺",
    "😸",
    "😹",
    "😻",
    "😼",
    "😽",
    "🙀",
    "😿",
    "😾",
    "🤲",
    "👐",
    "🙌",
    "👏",
    "🤝",
    "👍",
    "👎",
    "👊",
    "✊",
    "🤛",
    "🤜",
    "🤞",
    "✌️",
    "🤟",
    "🤘",
    "🤙",
    "👈",
    "👉",
    "👆",
    "🖕",
    "👇",
    "☝️",
    "👍🏻",
    "👎🏻",
    "👊🏻",
    "✊🏻",
    "🤛🏻",
    "🤜🏻",
    "🤞🏻",
    "✌🏻",
    "🤟🏻",
    "🤘🏻",
    "🤙🏻",
    "👈🏻",
    "👉🏻",
    "👆🏻",
    "🖕🏻",
    "👇🏻",
    "☝🏻",
    "👍🏼",
    "👎🏼",
    "👊🏼",
    "✊🏼",
    "🤛🏼",
    "🤜🏼",
    "🤞🏼",
    "✌🏼",
    "🤟🏼",
    "🤘🏼",
    "🤙🏼",
    "👈🏼",
    "👉🏼",
    "👆🏼",
    "🖕🏼",
    "👇🏼",
    "☝🏼",
    "👍🏽",
    "👎🏽",
    "👊🏽",
    "✊🏽",
    "🤛🏽",
    "🤜🏽",
    "🤞🏽",
    "✌🏽",
    "🤟🏽",
    "🤘🏽",
    "🤙🏽",
    "👈🏽",
    "👉🏽",
    "👆🏽",
    "🖕🏽",
    "👇🏽",
    "☝🏽",
    "👍🏾",
    "👎🏾",
    "👊🏾",
    "✊🏾",
    "🤛🏾",
    "🤜🏾",
    "🤞🏾",
    "✌🏾",
    "🤟🏾",
    "🤘🏾",
    "🤙🏾",
    "👈🏾",
    "👉🏾",
    "👆🏾",
    "🖕🏾",
    "👇🏾",
    "☝🏾",
    "👍🏿",
    "👎🏿",
    "👊🏿",
    "✊🏿",
    "🤛🏿",
    "🤜🏿",
    "🤞🏿",
    "✌🏿",
    "🤟🏿",
    "🤘🏿",
    "🤙🏿",
    "👈🏿",
    "👉🏿",
    "👆🏿",
    "🖕🏿",
    "👇🏿",
    "☝🏿",
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 9, // Adjust the number of emojis per row
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: emojis.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onEmojiSelected(emojis[index]);
          },
          child: Center(
            child: Text(
              emojis[index],
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      },
    );
  }
}

class AppIcons {
  static const Vector = 'assets/Vector.png';
  static const photo = 'assets/photo.png';
  static const Sent = 'assets/sent.png';
  static const flute = 'assets/flute.png';
}

