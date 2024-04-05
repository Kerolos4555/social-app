import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?) validate;
  final IconData prefix;
  final IconData? suffix;
  final Function()? onSuffixPressed;
  final bool isVisible;
  final Function(String)? onChange;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.type,
    required this.validate,
    required this.prefix,
    this.suffix,
    this.onSuffixPressed,
    this.isVisible = false,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onChange,
      obscureText: isVisible,
      validator: validate,
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: onSuffixPressed,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.blue,
        ),
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
