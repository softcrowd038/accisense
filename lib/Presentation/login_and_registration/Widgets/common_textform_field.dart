import 'package:flutter/material.dart';

class CommonTextFormfield extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  const CommonTextFormfield(
      {super.key,
      required this.label,
      required this.hint,
      required this.obscure,
      required this.controller,
      required this.validator,
      required this.onChanged,
      required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autocorrect: true,
      obscureText: obscure,
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
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
          labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: suffixIcon),
    );
  }
}
