import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social_cubit/social_cubit.dart';
import 'package:social_app/cubits/social_cubit/social_state.dart';
import 'package:social_app/widgets/create_new_post.dart';
import 'package:social_app/widgets/home_card.dart';
import 'package:social_app/widgets/post_card.dart';

class FeedsPage extends StatelessWidget {
  const FeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).userModel == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SocialCubit.get(context).posts.isNotEmpty &&
                    SocialCubit.get(context).userModel != null
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const HomeCard(),
                        CreateNewPost(
                          image: SocialCubit.get(context).userModel!.image,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: SocialCubit.get(context).posts.length,
                          itemBuilder: (context, index) {
                            return PostCard(
                                post: SocialCubit.get(context).posts[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                : SocialCubit.get(context).posts.isEmpty &&
                        SocialCubit.get(context).userModel != null
                    ? Center(
                        child: CreateNewPost(
                          image: SocialCubit.get(context).userModel!.image,
                        ),
                      )
                    : const Center(
                        child: Text(
                          'There was an error',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      );
      },
    );
  }
}
