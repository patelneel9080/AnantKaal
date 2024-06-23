import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isPasswordVisible = false.obs;
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode postalFocusNode = FocusNode();
  final countryFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  String? fullName;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? postalCode;
  DateTime? selectedDate;
  String? selectedGender;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  bool obscurePassword = true;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final selecteGender = ''.obs;
  final List<String> countries = ['Country 1', 'Country 2', 'Country 3'];
  final List<String> states = ['State 1', 'State 2', 'State 3'];
  final List<String> cities = ['City 1', 'City 2', 'City 3'];
  bool showValidationErrors = false;

  void setFullName(String value) => fullName = value;

  void setEmail(String value) => email = value;

  void setPassword(String value) => password = value;

  void setPhone(String value) => phone = value;

  void setAddress(String value) => address = value;

  void setPostalCode(String value) => postalCode = value;

  void setGender(String? value) {
    selectedGender = value;
    update(); // Notify listeners that selectedGender has changed
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    } else if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
  // void setSelectedDate(DateTime value) => selectedDate = value;
  void setSelectedDate(DateTime value){
    selectedDate = value;
    update();
  }
  @override
  void onInit() {
    super.onInit();
    fullNameFocusNode.addListener(update);
    emailFocusNode.addListener(update);
    phoneFocusNode.addListener(update);
    passwordFocusNode.addListener(update);
    addressFocusNode.addListener(update);
    postalFocusNode.addListener(update);
    dobFocusNode.addListener(update);
    countryFocusNode.addListener(update);
    stateFocusNode.addListener(update);
    cityFocusNode.addListener(update);
  }

  @override
  void onClose() {
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    addressFocusNode.dispose();
    postalFocusNode.dispose();
    dobFocusNode.dispose();
    addressController.dispose();
    passwordController.dispose();
    countryFocusNode.dispose();
    stateFocusNode.dispose();
    cityFocusNode.dispose();
    super.onClose();
  }

  void setShowValidationErrors(bool value) {
    showValidationErrors = value;
    update();
  }

  void updateCountry(String? value) {
    selectedCountry = value;
    // Update states based on selected country
    update();
  }

  void setCountry(String? value) {
    if (selectedCountry != value) {
      selectedCountry = value;
      selectedState = null; // Reset state when country changes
      selectedCity = null; // Reset city when country changes
      update();
    }
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void setState(String? value) {
    if (selectedState != value) {
      selectedState = value;
      selectedCity = null; // Reset city when state changes
      update();
    }
  }

  String? validatePostal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Postal code cannot be empty';
    } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'Postal code must be a 6-digit number';
    }
    return null;
  }

  String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  void setsGender(String? gender) {
    selecteGender.value = gender ?? '';
  }

  void setCity(String? value) {
    selectedCity = value;
  }

  void updateState(String? value) {
    selectedState = value;
    // Update cities based on selected state
    update();
  }

  void updateCity(String? value) {
    selectedCity = value;
    update();
  }

  Future<void> signUp(
      String? fullName,
      String? email,
      String? phone,
      String gender,
      String? address,
      String city,
      String state,
      String dateOfBirth,
      ) async {
    final url = Uri.parse("https://api.baii.me/api/createglobaluser");
    final headers = {
      "AuthToken": "2ec26ad9-e039-445e-915e-zACl56sr2q",
      "Content-Type": "application/json"
    };

    final body = json.encode({
      "name": fullName,
      "email": email,
      "phone_number": phone,
      "gender": gender,
      "address": address,
      "city": city,
      "state": state,
      "date_of_birth": dateOfBirth,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Get.snackbar('Login', 'Login Successfull');
        print("Sign Up Successful: ${response.body}");
        // Handle successful signup, e.g., navigate to next screen
      } else {
        print("Sign Up Failed: ${response.statusCode} ${response.body}");
        // Handle specific status codes
        if (response.statusCode == 401) {
          print("Unauthorized Request: Check your authorization token");
        }
        // Show error message
        Get.snackbar(
          'Sign Up Failed',
          'Error: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error during sign up: $e");
      // Handle network errors or exceptions here
      Get.snackbar(
        'Sign Up Error',
        'Error: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String email) async {
    final response = await http
        .get(Uri.parse('https://api.baii.me/api/getuser?email=$email'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

}
