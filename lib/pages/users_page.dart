import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social_cubit/social_cubit.dart';
import 'package:social_app/cubits/social_cubit/social_state.dart';
import 'package:social_app/pages/chat_page.dart';
import 'package:social_app/widgets/custom_user_widget.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).users.isNotEmpty &&
                SocialCubit.get(context).userModel != null
            ? ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatPage(
                              userModel: SocialCubit.get(context).users[index],
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SocialCubit.get(context).userModel!.uID ==
                              SocialCubit.get(context).users[index].uID
                          ? UserWidget(
                              image:
                                  SocialCubit.get(context).users[index].image,
                              name:
                                  '${SocialCubit.get(context).users[index].name} (You)',
                            )
                          : UserWidget(
                              image:
                                  SocialCubit.get(context).users[index].image,
                              name: SocialCubit.get(context).users[index].name,
                            ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                    ),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[400],
                    ),
                  );
                },
                itemCount: SocialCubit.get(context).users.length,
              )
            : SocialCubit.get(context).users.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : const Center(
                    child: Text(
                      'There was an error when trying to get users',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
      },
    );
  }
}
