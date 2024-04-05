import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social_cubit/social_cubit.dart';
import 'package:social_app/cubits/social_cubit/social_state.dart';
import 'package:social_app/widgets/custom_user_widget.dart';
import 'package:social_app/widgets/text_button_with_icon.dart';

class NewPostsPage extends StatefulWidget {
  const NewPostsPage({super.key});

  @override
  State<NewPostsPage> createState() => _NewPostsPageState();
}

class _NewPostsPageState extends State<NewPostsPage> {
  TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: const Text(
              'Create post',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).createNewPost(
                    text: postController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'POST',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  const Center(
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                UserWidget(
                  image: SocialCubit.get(context).userModel!.image,
                  name: SocialCubit.get(context).userModel!.name,
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What\'s on your mind...',
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImageURL != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              SocialCubit.get(context).postImageURL!,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextIconButton(
                      onPress: () {
                        SocialCubit.get(context).getPostImage();
                      },
                      icon: Icons.image,
                      text: 'add photo',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
