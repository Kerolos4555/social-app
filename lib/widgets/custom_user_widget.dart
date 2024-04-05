import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  final String image;
  final String name;
  const UserWidget({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            image,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
