import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social_cubit/social_cubit.dart';
import 'package:social_app/cubits/social_cubit/social_state.dart';
import 'package:social_app/widgets/custom_text_form_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = SocialCubit.get(context).userModel!.name;
        bioController.text = SocialCubit.get(context).userModel!.bio;
        phoneController.text = SocialCubit.get(context).userModel!.phone;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 5,
            title: const Text(
              'Edit Profile',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                child: const Text(
                  'UPDATE',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  if (state is UserUpdateLoadingState)
                    const LinearProgressIndicator(
                      color: Colors.blue,
                    ),
                  if (state is UserUpdateLoadingState)
                    const SizedBox(
                      height: 10,
                    ),
                  SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        SocialCubit.get(context).coverImage ==
                                                null
                                            ? NetworkImage(
                                                SocialCubit.get(context)
                                                    .userModel!
                                                    .coverImage,
                                              )
                                            : FileImage(SocialCubit.get(context)
                                                    .coverImage!)
                                                as ImageProvider<Object>,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      SocialCubit.get(context).profileImage ==
                                              null
                                          ? NetworkImage(
                                              SocialCubit.get(context)
                                                  .userModel!
                                                  .image,
                                            )
                                          : FileImage(SocialCubit.get(context)
                                                  .profileImage!)
                                              as ImageProvider<Object>?,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    labelText: 'Name',
                    hintText: 'Name',
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your name';
                      }
                      return null;
                    },
                    prefix: Icons.person_2_outlined,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    labelText: 'bio...',
                    hintText: 'bio',
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'write your bio information';
                      }
                      return null;
                    },
                    prefix: Icons.info_outline,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    labelText: 'phone',
                    hintText: 'phone',
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'enter your phone number';
                      }
                      return null;
                    },
                    prefix: Icons.phone_android_outlined,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
