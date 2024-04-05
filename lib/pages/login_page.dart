import 'package:social_app/cubits/login_cubit/login_cubit.dart';
import 'package:social_app/cubits/login_cubit/login_state.dart';
import 'package:social_app/helper/cached_helper.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/pages/register_page.dart';
import 'package:social_app/shared/show_snack_bar.dart';
import 'package:social_app/widgets/custom_material_button.dart';
import 'package:social_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CachedHelper.saveData(
              key: 'uID',
              value: state.uID,
            ).then(
              (value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomeLayout();
                    },
                  ),
                  (route) => false,
                );
              },
            ).catchError(
              (error) {
                debugPrint('There was an error when save uID');
              },
            );
          }
          if (state is LoginErrorState) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Login Now to communicate with your friends.',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Email';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          labelText: 'Email',
                          hintText: 'Enter your Email',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          isVisible: LoginCubit.get(context).isVisible,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          prefix: Icons.lock_outline,
                          suffix: LoginCubit.get(context).suffix,
                          onSuffixPressed: () {
                            LoginCubit.get(context).changePasswordSuffixIcon();
                          },
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          labelText: 'Password',
                          hintText: 'Enter your Password',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        state is! LoginLoadingState
                            ? CustomMaterialButton(
                                title: 'LOGIN',
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const RegisterPage();
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
