import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/login_screen.dart';
import '../screens/user_detailed_screen.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var userData = {}.obs;
  var isLoading = false.obs;

  void login() async {
    if (email.value.isEmpty) {
      Get.snackbar('Error', 'Please enter an email');
      return;
    }

    isLoading(true);

    var url = Uri.parse('https://api.baii.me/api/showglobaluser');
    var headers = {
      'AuthToken': '2ec26ad9-e039-445e-915e-zACl56sr2q',
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({'email': email.value});

    print('Request URL: $url');
    print('Request Headers: $headers');
    print('Request Body: $body');

    var response = await http.post(url, headers: headers, body: body);

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    isLoading(false);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == 'true') {
        userData.value = responseData['data'][0];
        Get.snackbar('Login', 'Login Successfull');
        Get.to(() => UserDetailedScreen());
      } else {
        Get.snackbar('Error', responseData['message']);
      }
    } else {
      Get.snackbar('Error', 'Invalid email');
    }
  }
}
