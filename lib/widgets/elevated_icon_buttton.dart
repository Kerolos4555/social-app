import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {
  final void Function() onPress;
  final String text;
  final IconData icon;
  const ElevatedIconButton(
      {super.key, required this.onPress, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(88, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
      onPressed: onPress,
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
