import 'package:flutter/material.dart';
import 'package:social_app/pages/new_posts_page.dart';

class CreateNewPost extends StatelessWidget {
  final String image;
  const CreateNewPost({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              image,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const NewPostsPage();
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                alignment: Alignment.centerLeft,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(),
                  shape: BoxShape.rectangle,
                ),
                child: const Text(
                  'What\'s on your mind?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
