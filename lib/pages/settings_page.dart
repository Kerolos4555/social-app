import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social_cubit/social_cubit.dart';
import 'package:social_app/cubits/social_cubit/social_state.dart';
import 'package:social_app/pages/edit_profile_page.dart';
import 'package:social_app/pages/login_page.dart';
import 'package:social_app/widgets/elevated_icon_buttton.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginPage();
              },
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return SocialCubit.get(context).userModel != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      SocialCubit.get(context)
                                          .userModel!
                                          .coverImage,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    SocialCubit.get(context).userModel!.image,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        SocialCubit.get(context).userModel!.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        SocialCubit.get(context).userModel!.bio,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedIconButton(
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const EditProfilePage();
                                    },
                                  ),
                                );
                              },
                              text: 'Edit',
                              icon: Icons.edit,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ElevatedIconButton(
                            onPress: () {
                              SocialCubit.get(context).signOut();
                            },
                            text: 'LOGOUT',
                            icon: Icons.logout,
                          ),
                        ],
                      ),
                    ],
                  ),
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
