import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

class Commnications extends StatefulWidget {
  const Commnications({super.key});

  @override
  State<Commnications> createState() => _CommnicationsState();
}

class _CommnicationsState extends State<Commnications> {
  TextEditingController chatController = Get.put(TextEditingController());
  TextEditingController emailController = Get.put(TextEditingController());
  TextEditingController phoneController = Get.put(TextEditingController());
  TextEditingController addressController = Get.put(TextEditingController());
  TextEditingController genderController = Get.put(TextEditingController());
  TextEditingController cityController = Get.put(TextEditingController());
  TextEditingController stateController = Get.put(TextEditingController()); // Add state controller

  ShowgloabalChat showchat = Get.put(ShowgloabalChat());
  GochatApiController showchats = Get.put(GochatApiController());

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
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width / 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: SvgPicture.asset(AppIcons.Vector),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset(AppIcons.photo),
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
                  state: stateController.text, // Include the state field
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
                  child: SvgPicture.asset(AppIcons.Sent),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height / 12),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.active_Textfild_color,
          title: SizedBox(
            height: Get.height / 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Name",
                      style: TextStyle(
                        fontSize: Get.width / 25,
                        color: AppColor.text_color,
                        fontFamily: GoogleFonts.exo().fontFamily,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(AppIcons.fluent),
              ],
            ),
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
                  Text(
                    showchat.showgloabal_data['data'][0]['user_details'][0]
                    ['email'],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names

class ShowgloabalChat extends GetxController {
  var isloading = false.obs;
  var showgloabal_data;

  Future showgloabal_Fuction() async {
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
class SinupApiController extends GetxController {
  var isLoding = false.obs;
  var Sinup_data;

  Future SinupApiController_faction({
    required String FullName,
    required String Phone,
    required String Email,
    required String Password,
    required String Address,
  }) async {
    try {
      if (kDebugMode) {
        print('FirstName :- $FullName');
        print('Phonenumber :- $Phone');
        print('LastName :- $Email');
        print('Email :- $Password');
        print('Password :- $Address');
      }

      Map<String, dynamic> body = {
        'name': FullName,
        'phone_number': Phone,
        'email': Email,
        'address': Address,
      };

      if (kDebugMode) {
        print(body);
      }

      final responce = await http.post(
        Uri.parse(AppUrl.createglobaluser),
        headers: {'AuthToken': '2ec26ad9-e039-445e-915e-zACl56sr2q'},
        body: body,
      );
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Sinup_data = jsonDecode(responce.body);
        if (kDebugMode) {
          print("Sinup Data :-$Sinup_data");
        }
      } else {
        throw {
          "Sinup Data Error this :- ${responce.statusCode} , ${responce.body}"
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print("Sinup Data Error = $e");
      }
    } finally {
      isLoding.value = false;
    }
  }
}
class AppIcons {
  static const google_icons = 'assets/icons/google_logo.svg';
  static const profile_icons = 'assets/icons/profile.svg';
  static const down_svg = 'assets/icons/down.svg';
  static const fluent = 'assets/icons/fluent-emoji-flat_magic-wand.svg';
  static const Sent = 'assets/icons/Sent.svg';
  static const Vector = 'assets/icons/Vector.svg';
  static const photo = 'assets/icons/photo.svg';
  static const date = 'assets/icons/date.svg';
}

class AppUrl {
  static const base_url = "https://api.baii.me/api/";

  //showglobalchat

  static const showglobalchat = "${base_url}showglobalchat";
  static const createglobaluser = "${base_url}createglobaluser";
}
class GochatApiController extends GetxController {
  var isloding = false.obs;
  var data;

  Future SinupApiController_faction({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String gender,
    required String city,
    required String state, // Add the state field
  }) async {
    try {
      if (kDebugMode) {
        print('Name: $name');
        print('Email: $email');
        print('Phone Number: $phoneNumber');
        print('Address: $address');
        print('Gender: $gender');
        print('City: $city');
        print('State: $state'); // Print the state field
      }

      Map<String, dynamic> body = {
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'address': address,
        'gender': gender,
        'city': city,
        'state': state, // Include the state field
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
        body: json.encode(body), // Ensure the body is encoded to JSON
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
