import 'package:anantkaal/screens/splash_screen.dart';
import 'package:anantkaal/utils/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import '../utils/constant/const_color.dart';


class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
            color: Colors.black,
          image: DecorationImage(image: AssetImage( 'assets/background.png'),fit: BoxFit.cover,opacity: .8)
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff438E96),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      controller.email.value = value;
                    },
                    style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: kPrimaryColor),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: kPrimaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                      controller.login();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color(0xff438E96), // Text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white),
                    )
                        : Text(
                      'Login',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}