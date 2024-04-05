import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final void Function() onPress;
  final IconData icon;
  final String text;
  const TextIconButton({
    super.key,
    required this.onPress,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 24,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
