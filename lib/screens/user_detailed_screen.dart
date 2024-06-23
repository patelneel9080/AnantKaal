import 'package:anantkaal/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/login_controller.dart';

class UserDetailedScreen extends StatelessWidget {
  final LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.userData.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            var userData = controller.userData;
            return ListView(
              children: [
                ListTile(
                  title: Text('ID'),
                  subtitle: Text(userData['id'].toString()),
                ),
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(userData['name'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(userData['email'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Phone Number'),
                  subtitle: Text(userData['phone_number'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Gender'),
                  subtitle: Text(userData['gender'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Address'),
                  subtitle: Text(userData['address'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('City'),
                  subtitle: Text(userData['city'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('State'),
                  subtitle: Text(userData['state'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Date of Birth'),
                  subtitle: Text(userData['date_of_birth'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Created At'),
                  subtitle: Text(userData['created_at'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Updated At'),
                  subtitle: Text(userData['updated_at'] ?? 'N/A'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => SplashScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xff438E96), // Text color
                    padding: EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                )
              ],
            );
          }
        }),
      ),
    );
  }
}