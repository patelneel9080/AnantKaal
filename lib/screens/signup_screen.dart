import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../controller/signup_controller.dart';
import '../utils/constant/const_color.dart';
import '../utils/constant/const_variables.dart';
import '../utils/constant/const_widgets.dart';
import '../utils/constant/constants.dart';
import 'chat_screen.dart';


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
                    SizedBox(height: 6),
                    buildCustomTextField(
                      focusNode: controller.fullNameFocusNode,
                      onChanged: controller.setFullName,
                      validator: controller.validateName,
                      controller: controller.fullNameController,
                      hintext: 'Enter your Name',
                      showError: controller.showValidationErrors,
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
                      showError: controller.showValidationErrors,
                      validator: controller.validateEmail,
                      controller: controller.emailController,
                      hintext: 'Enter your E-mail Address',
                    ),
                    SizedBox(height: 16),
                    buildInputLabel('Password'),
                    SizedBox(height: 4),
                    buildPasswordTextField(
                      focusNode: controller.passwordFocusNode,
                      controller: controller.passwordController,
                      hintext: "Enter your password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                      showError: controller.showValidationErrors,
                      controllerInstance: controller,
                    ),

                    SizedBox(height: 16),
                    buildInputLabel('Address'),
                    SizedBox(height: 4),
                    buildMultilineTextField(
                      focusNode: controller.addressFocusNode,
                      onChanged: controller.setAddress,
                      controller: controller.addressController,
                      validator: controller.validateField,
                      // Use appropriate validator
                      showError: controller.showValidationErrors,
                    ),
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
                    SizedBox(
                        height: 4),
                    buildCustomTextField(
                      focusNode: controller.postalFocusNode,
                      onChanged: controller.setPostalCode,
                      keyboardType: TextInputType.number,
                      showError: controller.showValidationErrors,
                      controller: controller.postalCodeController,
                      hintext: 'Enter Postal Code',
                      validator: controller.validatePostal, // Ensure validator is set
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
                    buildGenderRadioButtons(
                        controller: controller,
                        showError: controller.showValidationErrors),
                    const SizedBox(height: 16),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed:() async {
                        controller.setShowValidationErrors(true);

                        // Validate phone number and DOB
                        final dobError = controller.validateDOB(controller.selectedDate);

                        // Ensure the form is valid
                        if (controller.formKey.currentState!.validate() && dobError == null) {
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
                          Get.snackbar('Login', 'Login Successfull');
                          var userData = await controller.fetchUserData(controller.email ?? '');
                          Get.to(() => ChatScreen(fullName: controller.fullName!));

                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color(0xff438E96), // Text color
                        padding: EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        fixedSize: Size(Get.width, Get.height / 15,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child:  Text(
                        Signup_String.Create_Account,
                        style: TextStyle(
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          fontSize: Get.width / 18,
                          color: AppColor.text_color,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ) ,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}