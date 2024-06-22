 import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:intl/intl.dart';
  import 'package:http/http.dart' as http;
  import 'package:intl_phone_field/intl_phone_field.dart';
  import 'package:get/get.dart';
  import '../utils/constants.dart';
  import 'chat_screen.dart';
    String error = '';

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
                        validator: controller._validateName,
                        controller: controller.fullNameController, hintext: 'Enter your Name',
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
                        validator: controller._validateEmail,
                        controller: controller.emailController, hintext: 'Enter your E-mail Address',
                      ),
                      SizedBox(height: 16),
                      buildInputLabel('Password'),
                      SizedBox(height: 4),
                      buildCustomTextField(
                        focusNode: controller.passwordFocusNode,
                        onChanged: controller.setPassword,
                        validator: controller._validatePassword,
                        obscureText: true,
                        controller: controller.passwordController, hintext: 'Enter your Password',
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
                        controller: controller.postalCodeController, hintext: 'Enter Postal Code',
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
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     if (controller.formKey.currentState!.validate()) {
                      //       await controller.signUp(
                      //         controller.fullName,
                      //         controller.email,
                      //         controller.phone,
                      //         controller.selectedGender ?? '',
                      //         controller.address,
                      //         controller.selectedCity ?? '',
                      //         controller.selectedState ?? '',
                      //         DateFormat('dd/MM/yyyy').format(controller.selectedDate!),
                      //       );
                      //
                      //       var userData = await controller.fetchUserData(controller.email ?? '');
                      //
                      //         // Get.to(
                      //         //           () => Commnications(),
                      //         //       duration: Duration(milliseconds: 800),
                      //         //       transition: Transition.downToUp,
                      //         //     );
                      //
                      //     }
                      //   },
                      //   child: Text('Fetch User Data and Navigate to Chat'),
                      // ),
                      GestureDetector(
                        onTap: () async {
                          if (controller.formKey.currentState!.validate()) {
                            await controller.signUp(
                              controller.fullName,
                              controller.email,
                              controller.phone,
                              controller.selectedGender ?? '',
                              controller.address,
                              controller.selectedCity ?? '',
                              controller.selectedState ?? '',
                              DateFormat('dd/MM/yyyy').format(controller.selectedDate!),
                            );


                            var userData = await controller.fetchUserData(controller.email ?? '');
                            Get.to(() => Commnications());
                          }
                        },
                        child: Container(
                          width: Get.width,
                          height: Get.height / 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Get.width / 50,
                            ),
                            color: AppColor.active_Textfild_color,
                          ),
                          child: Center(
                            child: Text(
                              Sinup_String.Create_Account,
                              style: TextStyle(
                                fontFamily:
                                GoogleFonts.openSans().fontFamily,
                                fontSize: Get.width / 18,
                                color: AppColor.text_color,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
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
      final Widget? suffixIcon,
      required String hintext,
      final bool? obscureText,
      required final TextEditingController controller,
      String? Function(String?)? validator,
    }) {
      String? errorText = validator?.call(controller.text);
      Color borderColor = focusNode.hasFocus ? kPrimaryColor
          : Colors.grey;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: focusNode.hasFocus ? kPrimaryColor.withOpacity(0.1)
                  : Colors.white,
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              focusNode: focusNode,
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText ?? false,
              onChanged: onChanged,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                hintText: hintext,
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          // if (validator != null)
          //   Padding(
          //     padding: const EdgeInsets.only(left: 16, top: 4),
          //     child: Text(
          //       errorText ?? '',
          //       style: TextStyle(color: Colors.red, fontSize: 12),
          //     ),
          //   ),
        ],
      );
    }

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
   return GetBuilder<SignUpController>(
     builder: (controller) => Row(
       children: [
         buildRadioButton('Male', 'male', controller),
         buildRadioButton('Female', 'female', controller),
         buildRadioButton('Prefer not to say', 'preferNotToSay', controller),
       ],
     ),
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
         onChanged: (newValue) {
           controller.setGender(newValue);
         },
       ),
       Text(
         title,
         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
       ),
     ],
   );
 }


 class SignUpController extends GetxController {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController postalCodeController = TextEditingController();

    final List<String> countries = ['Country 1', 'Country 2', 'Country 3'];
    final List<String> states = ['State 1', 'State 2', 'State 3'];
    final List<String> cities = ['City 1', 'City 2', 'City 3'];

    void setFullName(String value) => fullName = value;
    void setEmail(String value) => email = value;
    void setPassword(String value) => password = value;
    void setPhone(String value) => phone = value;
    void setAddress(String value) => address = value;
    void setPostalCode(String value) => postalCode = value;
    void setGender(String? value) => selectedGender = value;
    void setSelectedDate(DateTime value) => selectedDate = value;
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
          print("Sign Up Successful: ${response.body}");
          // Handle successful signup, e.g., navigate to next screen
          Get.to(() => Commnications());
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
      final response = await http.get(Uri.parse('https://api.baii.me/api/getuser?email=$email'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
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

  }
