import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

class Communications extends StatefulWidget {
  final String name;

  const Communications({Key? key, required this.name}) : super(key: key);

  @override
  State<Communications> createState() => _CommunicationsState();
}

class _CommunicationsState extends State<Communications> {
  final TextEditingController chatController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  final ShowgloabalChat showchat = Get.put(ShowgloabalChat());
  final GochatApiController showchats = Get.put(GochatApiController());

  @override
  void initState() {
    Future.microtask(() async {
      await showchat.showgloabal_Fuction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height / 12),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.active_Textfild_color,
          title: Column(
            children: [
             SizedBox( height: Get.height / 35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height / 80),
                      Text(
                        Commnications_text.Group_Chat,
                        style: TextStyle(
                          fontSize: Get.width / 13,
                          color: AppColor.text_color,
                          fontFamily: GoogleFonts.cherrySwash().fontFamily,
                        ),
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: Get.width / 25,
                          color: AppColor.text_color,
                          fontFamily: GoogleFonts.exo().fontFamily,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(AppIcons.fluent),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.text_color,
        ),
        child: Obx(
              () {
            if (showchat.isloading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  // Text(
                  //   showchat.showgloabal_data['data'][0]['user_details'][0]
                  //   ['email'],
                  // ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width / 35,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: Get.width / 25),
            Container(
              width: Get.width / 1.4,
              height: Get.height / 15,
              decoration: BoxDecoration(
                color: AppColor.Textfild_color,
                borderRadius: BorderRadius.circular(Get.width / 50),
                border: Border.all(
                  color: AppColor.active_Textfild_color,
                ),
              ),
              child: Center(
                child: TextField(
                  controller: chatController,
                  decoration: InputDecoration(
                    hintText: Commnications_text.Enter_The_Message,
                    hintStyle: TextStyle(
                      color: AppColor.active_Textfild_color,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(AppIcons.Vector),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(AppIcons.photo),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showchats.SinupApiController_faction(
                  name: chatController.text,
                  email: emailController.text,
                  phoneNumber: phoneController.text,
                  address: addressController.text,
                  gender: genderController.text,
                  city: cityController.text,
                  state: stateController.text,
                );
              },
              child: Container(
                width: Get.width / 7,
                height: Get.height / 15,
                decoration: BoxDecoration(
                  color: AppColor.active_Textfild_color,
                  borderRadius: BorderRadius.circular(Get.width / 50),
                  border: Border.all(
                    color: AppColor.active_Textfild_color,
                  ),
                ),
                child: Center(
                  child: Image.asset(AppIcons.Sent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowgloabalChat extends GetxController {
  var isloading = false.obs;
  var showgloabal_data;

  Future<void> showgloabal_Fuction() async {
    try {
      isloading.value = true;

      final responce = await http.get(
        Uri.parse(AppUrl.showglobalchat),
        headers: {
          'AuthToken': '2ec26ad9-e039-445e-915e-zACl56sr2q',
        },
      );
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        showgloabal_data = jsonDecode(responce.body);
        print(jsonDecode(responce.body));
      } else {
        throw {
          "Error this showgloabal_data :- ${responce.body} , ${responce.statusCode}",
        };
      }
    } finally {
      isloading.value = false;
    }
  }
}

class GochatApiController extends GetxController {
  var isloding = false.obs;
  var data;

  Future<void> SinupApiController_faction({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String gender,
    required String city,
    required String state,
  }) async {
    try {
      if (kDebugMode) {
        print('Name: $name');
        print('Email: $email');
        print('Phone Number: $phoneNumber');
        print('Address: $address');
        print('Gender: $gender');
        print('City: $city');
        print('State: $state');
      }

      Map<String, dynamic> body = {
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'address': address,
        'gender': gender,
        'city': city,
        'state': state,
      };

      if (kDebugMode) {
        print(body);
      }

      final response = await http.post(
        Uri.parse(AppUrl.createglobaluser),
        headers: {
          'AuthToken': '2ec26ad9-e039-445e-915e-zACl56sr2q',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        data = jsonDecode(response.body);
        if (kDebugMode) {
          print("Data: $data");
        }
      } else {
        throw {
          "Sign-up Data Error: ${response.statusCode} , ${response.body}"
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print("Sign-up Data Error: $e");
      }
    } finally {
      isloding.value = false;
    }
  }
}

class AppIcons {
  static const google_icons = 'assets/icons/google_logo.svg';
  static const profile_icons = 'assets/icons/profile.svg';
  static const down_svg = 'assets/icons/down.svg';
  static const fluent = 'assets/flute.png';
  static const Sent = 'assets/sent.png';
  static const Vector = 'assets/Vector.png';
  static const photo = 'assets/photo.png';
  static const date = 'assets/icons/date.svg';
}

class AppUrl {
  static const base_url = "https://api.baii.me/api/";

  static const showglobalchat = "${base_url}showglobalchat";
  static const createglobaluser = "${base_url}createglobaluser";
}
