import 'package:anantkaal/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splashscreen.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: GestureDetector(
            onTap:  () {
              Get.to(() => SignUpScreen());
            },
            child: Container(
              width: Get.width/2,
              height: Get.height / 18,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Get.width / 50,
                ),
                color: Colors.white
              ),
              child: Text("Sign In With Google",style: TextStyle(color: AppColor.active_Textfild_color,),),
            ),
          ),
        ),
      ),
    );
  }
}
