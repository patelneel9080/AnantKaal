import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:get/get.dart';
import '../utils/constants.dart';
import 'chat_screen.dart';

String? _validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  }
  return null;
}

String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email address';
  } else if (!value.contains('@')) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14),
                    Text(
                      'Sign Up',
                      style: kHeadingTextStyle,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Please enter your credentials to proceed',
                      style: GoogleFonts.exo(
                        textStyle: TextStyle(fontSize: 16, color: kTextColor),
                      ),
                    ),
                    SizedBox(height: 14),
                    buildInputLabel('Full Name'),
                    SizedBox(height: 4),
                    buildCustomTextField(
                      focusNode: controller.fullNameFocusNode,
                      onChanged: controller.setFullName,
                      validator: _validateName,
                    ),
                    SizedBox(height: 16),
                    buildInputLabel('Phone'),
                    SizedBox(height: 4),
                    buildIntlPhoneField(controller),
                    SizedBox(height: 16),
                    buildInputLabel('Email address'),
                    SizedBox(height: 4),
                    buildCustomTextField(
                      focusNode: controller.emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: controller.setEmail,
                      validator: _validateEmail,
                    ),
                    SizedBox(height: 16),
                    buildInputLabel('Password'),
                    SizedBox(height: 4),
                    buildCustomTextField(
                      focusNode: controller.passwordFocusNode,
                      onChanged: controller.setPassword,
                      validator: _validatePassword,
                    ),
                    SizedBox(height: 16),
                    buildInputLabel('Address'),
                    SizedBox(height: 4),
                    buildMultilineTextField(controller),
                    SizedBox(height: 16),
                    buildInputLabel('Country'),
                    SizedBox(height: 4),
                    buildCountryDropdown(controller),
                    SizedBox(height: 16),
                    buildInputLabel('State'),
                    SizedBox(height: 4),
                    buildStateDropdown(controller),
                    SizedBox(height: 16),
                    buildInputLabel('City'),
                    SizedBox(height: 4),
                    buildCityDropdown(controller),
                    SizedBox(height: 16),
                    buildInputLabel('Postal Code'),
                    SizedBox(height: 4),
                    buildCustomTextField(
                      focusNode: controller.postalFocusNode,
                      onChanged: controller.setPostalCode,
                    ),
                    SizedBox(height: 16),
                    buildInputLabel('My date of birth:'),
                    SizedBox(
                      height: 4,
                    ),
                    buildDateOfBirthField(context, controller,
                        focusNode: controller.dobFocusNode),
                    SizedBox(height: 16),
                    buildInputLabel('Gender'),
                    buildGenderRadioButtons(controller),
                    SizedBox(height: 16),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        await controller.signUp("uwbev", "a@gmail.com", "734853845348", "vwyvfc", "bybriyvbe", "bieybvry", "jhvceyvev", "neurbveribvierb");
                        // Fetch user data
                        var userData = await controller.fetchUserData('Vraj886@gmail.com');

                        if (userData != null) {
                          // Navigate to ChatScreen with fetched user data
                          Get.to(() => ChatScreen(userData: userData));
                        } else {
                          // Handle case where user data fetch failed
                          // Display an error message or retry option
                        }
                      },
                      child: Text('Fetch User Data and Navigate to Chat'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildInputLabel(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kInputLabelStyle,
        ),
      ],
    );
  }

  Widget buildCustomTextField({
    required FocusNode focusNode,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color:
            focusNode.hasFocus ? kPrimaryColor.withOpacity(0.1) : Colors.white,
        border: Border.all(
          color: focusNode.hasFocus ? kPrimaryColor : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        focusNode: focusNode,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildDateOfBirthField(
      BuildContext context, SignUpController controller,
      {required FocusNode focusNode}) {
    String formattedDate = controller.selectedDate == null
        ? 'Select Date of Birth'
        : DateFormat('dd/MM/yyyy').format(controller.selectedDate!);

    return GestureDetector(
      onTap: () {
        _selectDate(context, controller);
      },
      child: AbsorbPointer(
        child: Container(
          decoration: BoxDecoration(
            color: focusNode.hasFocus
                ? kPrimaryColor.withOpacity(0.1)
                : Colors.white,
            border: Border.all(
              color: focusNode.hasFocus ? kPrimaryColor : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: TextField(
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: 'Select Date of Birth',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.calendar_today),
            ),
            controller: TextEditingController(text: formattedDate),
            readOnly: true,
            onTap: () {
              _selectDate(context, controller);
            },
            style: TextStyle(color: Colors.black), // Ensure text color is black
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, SignUpController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != controller.selectedDate) {
      controller.setSelectedDate(picked);
    }
  }

  Widget buildMultilineTextField(SignUpController controller) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 100.0,
        maxHeight: 200.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: controller.addressFocusNode.hasFocus
              ? kPrimaryColor.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: controller.addressFocusNode.hasFocus
                ? kPrimaryColor
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          focusNode: controller.addressFocusNode,
          controller: controller.addressController,
          maxLines: null,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          onChanged: controller.setAddress,
          decoration: InputDecoration(
            hintText: "Address Line 1\nAddress Line 2\nAddress Line 3",
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildPasswordTextField(SignUpController controller) {
    return Container(
      decoration: BoxDecoration(
        color: controller.passwordFocusNode.hasFocus
            ? kPrimaryColor.withOpacity(0.1)
            : Colors.white,
        border: Border.all(
          color: controller.passwordFocusNode.hasFocus
              ? kPrimaryColor
              : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller.passwordController,
        focusNode: controller.passwordFocusNode,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        obscureText: controller.obscurePassword,
        onChanged: controller.setPassword,
        decoration: InputDecoration(
          hintText: "Password",
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              controller.obscurePassword
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onPressed: () {
              controller.togglePasswordVisibility();
            },
          ),
        ),
      ),
    );
  }

  Widget buildIntlPhoneField(SignUpController controller) {
    return Container(
      decoration: BoxDecoration(
        color: controller.phoneFocusNode.hasFocus
            ? kPrimaryColor.withOpacity(0.1)
            : Colors.white,
        border: Border.all(
          color:
              controller.phoneFocusNode.hasFocus ? kPrimaryColor : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntlPhoneField(
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        focusNode: controller.phoneFocusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        initialCountryCode: 'IN',
        onChanged: (phone) => controller.setPhone(phone.completeNumber),
      ),
    );
  }

  Widget buildCountryDropdown(SignUpController controller) {
    return Container(
      decoration: BoxDecoration(
        color: controller.countryFocusNode.hasFocus
            ? kPrimaryColor.withOpacity(0.1)
            : Colors.white,
        border: Border.all(
          color: controller.countryFocusNode.hasFocus
              ? kPrimaryColor
              : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16),
          border: InputBorder.none,
          hintText: 'Select Country',
        ),
        focusNode: controller.countryFocusNode,
        value: controller.selectedCountry,
        items: countriesData.keys.map((String country) {
          return DropdownMenuItem<String>(
            value: country,
            child: Text(
              country,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
          );
        }).toList(),
        onChanged: controller.setCountry,
        validator: (value) => value == null ? 'Please select a country' : null,
      ),
    );
  }

  Widget buildStateDropdown(SignUpController controller) {
    return Container(
      decoration: BoxDecoration(
        color: controller.stateFocusNode.hasFocus
            ? kPrimaryColor.withOpacity(0.1)
            : Colors.white,
        border: Border.all(
          color:
              controller.stateFocusNode.hasFocus ? kPrimaryColor : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: InputBorder.none,
          hintText: 'Select State',
        ),
        focusNode: controller.stateFocusNode,
        value: controller.selectedState,
        items: controller.selectedCountry != null
            ? countriesData[controller.selectedCountry!]!
                .keys
                .map((String state) {
                return DropdownMenuItem<String>(
                  value: state,
                  child: Text(
                    state,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                );
              }).toList()
            : [],
        onChanged: (value) {
          controller.setState(value);
          // Reset city selection when state changes
          controller.setCity(null);
        },
        validator: (value) => value == null ? 'Please select a state' : null,
      ),
    );
  }

  Widget buildCityDropdown(SignUpController controller) {
    return Container(
      decoration: BoxDecoration(
        color: controller.cityFocusNode.hasFocus
            ? kPrimaryColor.withOpacity(0.1)
            : Colors.white,
        border: Border.all(
          color:
              controller.cityFocusNode.hasFocus ? kPrimaryColor : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: 'Select City',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: InputBorder.none,
        ),
        value: controller.selectedCity,
        focusNode: controller.cityFocusNode,
        items: controller.selectedCountry != null &&
                controller.selectedState != null
            ? countriesData[controller.selectedCountry!]![
                        controller.selectedState!]
                    ?.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(
                      city,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                  );
                }).toList() ??
                []
            : [],
        onChanged: (value) {
          controller.setCity(value);
        },
        validator: (value) => value == null ? 'Please select a city' : null,
      ),
    );
  }

  Widget buildGenderRadioButtons(SignUpController controller) {
    return Row(
      children: [
        buildRadioButton('Male', 'male', controller),
        buildRadioButton('Female', 'female', controller),
        buildRadioButton('Prefer not to say', 'preferNotToSay', controller),
      ],
    );
  }

  Widget buildRadioButton(
      String title, String value, SignUpController controller) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: controller.selectedGender,
          activeColor: kPrimaryColor,
          onChanged: controller.setGender,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fullNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final countryFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final postalFocusNode = FocusNode();
  final dobFocusNode = FocusNode();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  String fullName = '';
  String email = '';
  String phone = '';
  String password = '';
  String address = '';
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String? selectedGender;
  String postalCode = '';
  DateTime? selectedDate;
  String? dob;
  bool obscurePassword = true;

  @override
  void onInit() {
    super.onInit();
    fullNameFocusNode.addListener(update);
    emailFocusNode.addListener(update);
    phoneFocusNode.addListener(update);
    passwordFocusNode.addListener(update);
    addressFocusNode.addListener(update);
    countryFocusNode.addListener(update);
    stateFocusNode.addListener(update);
    cityFocusNode.addListener(update);
    postalFocusNode.addListener(update);
    dobFocusNode.addListener(update);
  }

  @override
  void onClose() {
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    addressFocusNode.dispose();
    countryFocusNode.dispose();
    stateFocusNode.dispose();
    cityFocusNode.dispose();
    postalFocusNode.dispose();
    dobFocusNode.dispose();
    dobController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    } else if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  void setFullName(String value) {
    fullName = value;
  }

  void setEmail(String value) {
    email = value;
  }

  void setPhone(String value) {
    phone = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void setAddress(String value) {
    address = value;
  }

  void setCountry(String? value) {
    if (selectedCountry != value) {
      selectedCountry = value;
      selectedState = null; // Reset state when country changes
      selectedCity = null; // Reset city when country changes
      update();
    }
  }

  void setState(String? value) {
    if (selectedState != value) {
      selectedState = value;
      selectedCity = null; // Reset city when state changes
      update();
    }
  }

  void setCity(String? value) {
    selectedCity = value;
  }

  void setGender(String? value) {
    selectedGender = value;
  }

  void setPostalCode(String value) {
    postalCode = value;
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    dobController.text = DateFormat('dd/MM/yyyy').format(date);
    update();
  }

  Future<void> signUp(
    String fullName,
    String email,
    String phone,
    String selectedGender,
      String address,
      String selectedCity,
      String selectedState,
      String selectedDate
  ) async {
    final url = 'https://api.baii.me/api/createglobaluser';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'AuthToken' : '2ec26ad9-e039-445e-915e-zACl56sr2q'
        },
        body: jsonEncode(<String, dynamic>{
          'name': fullName,
          'email': email,
          'phone_number': phone,
          'gender': selectedGender,
          'address': address,
          'city': selectedCity,
          'state': selectedState,
          'date_of_birth': selectedDate,
          //'date_of_birth': DateFormat('dd/MM/yyyy').format(selectedDate!),
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Successful signup
        print('User signed up successfully!');
        print('API Response: ${response.body}');
        // You can navigate to the chat screen or perform any post-signup actions here
      } else {
        // Error occurred during signup
        print('Error signing up: ${response.body}');
        // Handle error and show appropriate message to user
      }
    } catch (e) {
      print('Error during signup: $e');
      // Handle network errors or exceptions here
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String email) async {
    final url = 'https://api.baii.me/api/showglobaluser';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // Replace 'Bearer your_api_token_here' with your actual API token
          'AuthToken' : '2ec26ad9-e039-445e-915e-zACl56sr2q'
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        // Successful API call
        print('User data fetched successfully!');
        print('API Response: ${response.body}');
        // Parse the response JSON and return the user data
        return jsonDecode(response.body);
      } else {
        // Error occurred during API call
        print('Error fetching user data: ${response.body}');
        // Handle error and return null or show appropriate message to user
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle network errors or exceptions here
      return null;
    }
  }
}
