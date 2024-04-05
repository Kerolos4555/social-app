import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final String title;
  final Function() onPress;

  const CustomMaterialButton({
    super.key,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 50,
        onPressed: onPress,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
