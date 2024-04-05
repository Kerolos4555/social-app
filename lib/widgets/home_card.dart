import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Image(
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
            image: NetworkImage(
              'https://img.freepik.com/free-photo/medium-shot-man-wearing-vr-glasses_23-2150394443.jpg?w=826&t=st=1706537471~exp=1706538071~hmac=0ade782037f49abf5760447f19b1cca9bfbe62970f9dcbeed65e55165e70e6a4',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Communicate with friends',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
