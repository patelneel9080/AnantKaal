import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool showPasswordToggle;
  final void Function()? onPasswordToggle;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.showPasswordToggle = false,
    this.onPasswordToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: focusNode.hasFocus ? Color(0xFFBFE0E2) : Colors.white,
            border: Border.all(
              color: focusNode.hasFocus ? Color(0xFF438E96) : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: InputBorder.none,
              suffixIcon: showPasswordToggle
                  ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: onPasswordToggle,
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
