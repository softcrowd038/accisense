import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hint;
  final String label;
  final TextInputType? keyboardType;
  final Color color;
  final Widget? suffixIcon;
  final void Function(String)? onChanged; // Update the signature of onTap

  const CustomTextField(
      {Key? key,
      required this.obscureText,
      required this.hint,
      required this.label,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      required this.color,
      required this.onChanged,
      required this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autocorrect: true,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.height * 0.018),
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: color,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
