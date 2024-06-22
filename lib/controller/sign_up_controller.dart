// ignore_for_file: non_constant_identifier_names, annotate_overrides

import 'package:flutter/cupertino.dart';

class VaildationController with ChangeNotifier {
  TextEditingController fullname_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController Address_controller = TextEditingController();
  TextEditingController postal_controller = TextEditingController();

  final phoneRegExp = RegExp(r'^\+?1?\d{9,15}$');
  final emailRegExp = RegExp(r'^\+?1?\d{9,15}$');
  final postal = RegExp(r'^\d{5}(-\d{4})?$|^[A-Za-z]\d[A-Za-z] \d[A-Za-z]\d$');

  bool _Full_Name_condition = false;
  bool _Phone_condition = false;
  bool _Email_condition = false;
  bool _Password_condition = false;
  bool _Address_condition = false;
  bool _postal_condition = false;

  String _Fullname_Error = '';
  String _Phone_Error = '';
  String _Email_Error = '';
  String _Password_Error = '';
  String _Adress_Error = '';
  String _postal_Error = '';

  get Full_Name_condition => _Full_Name_condition;

  get Phone_condition => _Phone_condition;

  get Email_condition => _Email_condition;

  get Password_condition => _Password_condition;

  get Address_condition => _Address_condition;

  get Fullname_Error => _Fullname_Error;

  get Phone_Error => _Phone_Error;

  get Email_Error => _Email_Error;

  get postal_Error => _postal_Error;

  get Password_Error => _Password_Error;

  get postal_condition => _postal_condition;

  get Adress_Error => _Adress_Error;

  void Validation() {
    if (fullname_controller.text.isEmpty) {
      _Full_Name_condition = true;
      _Fullname_Error = "Plese Input Your Flull Name";
    } else if (!RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$')
        .hasMatch(fullname_controller.text)) {
      _Full_Name_condition = true;
      _Fullname_Error = "Plese Input Your vaild Flull Name";
    } else {
      _Full_Name_condition = false;
      _Fullname_Error = "";
    }
    if (phone_controller.text.isEmpty) {
      _Phone_condition = true;
      _Phone_Error = "Plese Input Your Phone Number";
    } else {
      _Phone_condition = false;
      _Phone_Error = "";
    }
    if (email_controller.text.isEmpty) {
      _Email_condition = true;
      _Email_Error = "Plese Input Your Email Address";
    } else if (!emailRegExp.hasMatch(email_controller.text)) {
      _Email_condition = true;
      _Email_Error = "Plese Input Your Vild Email Address";
    } else {
      _Email_condition = false;
      _Email_Error = "";
    }
    if (password_controller.text.isEmpty) {
      _Password_condition = true;
      _Password_Error = "Plese Input Your Password";
    } else if (password_controller.text.length < 8) {
      _Password_condition = true;
      _Password_Error = "Password must be at least 8 characters long";
    } else if (!RegExp(r'[A-Z]').hasMatch(password_controller.text)) {
      _Password_condition = true;
      _Password_Error = "Password must contain at least one uppercase letter";
    } else if (!RegExp(r'[a-z]').hasMatch(password_controller.text)) {
      _Password_condition = true;
      _Password_Error = "Password must contain at least one lowercase letter";
    } else if (!RegExp(r'[0-9]').hasMatch(password_controller.text)) {
      _Password_condition = true;
      _Password_Error = "Password must contain at least one digit";
    } else if (!RegExp(r'[!@#\$&*~]').hasMatch(password_controller.text)) {
      _Password_condition = true;
      _Password_Error = "Password must contain at least one special character";
    } else {
      _Password_condition = false;
      _Password_Error = "";
    }
    if (Address_controller.text.isEmpty) {
      _Address_condition = true;
      _Adress_Error = "Plese Input Your Address";
    } else {
      _Address_condition = false;
      _Adress_Error = "";
    }

    if (postal_controller.text.isEmpty) {
      _postal_condition = true;
      _postal_Error = "Plese Input Your Postal";
    } else if (!RegExp(r'^\d{5}(-\d{4})?$|^[A-Za-z]\d[A-Za-z] \d[A-Za-z]\d$')
        .hasMatch(postal_controller.text)) {
      _postal_condition = true;
      _postal_Error = "Plese Input Your valid Postal";
    } else {
      _postal_condition = false;
      _postal_Error = "";
    }
    notifyListeners();
  }

  notifyListeners();
}