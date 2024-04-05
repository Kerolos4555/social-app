import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/cubits/register_cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
  IconData suffix = Icons.visibility_off_outlined;
  void changePasswordSuffixIcon() {
    isVisible = !isVisible;
    suffix =
        isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(RegisterPasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        userCreate(
          name: name,
          uID: value.user!.uid,
          phone: phone,
          email: email,
        );
      },
    ).catchError(
      (error) {
        emit(RegisterErrorState(error: error));
      },
    );
  }

  void userCreate({
    required String name,
    required String email,
    required String uID,
    required String phone,
    String bio = 'Write your bio',
    String cover =
        'https://img.freepik.com/free-photo/medium-shot-man-wearing-vr-glasses_23-2150394443.jpg?w=826&t=st=1706537471~exp=1706538071~hmac=0ade782037f49abf5760447f19b1cca9bfbe62970f9dcbeed65e55165e70e6a4',
    String image =
        'https://img.freepik.com/free-photo/medium-shot-woman-wearing-vr-glasses_23-2150394453.jpg?t=st=1706472264~exp=1706472864~hmac=f267bdc72d4642d0c8aa8517b86444e4f687e3b93883d4b6c141bad0e3af280d',
  }) {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uID: uID,
      image: image,
      coverImage: cover,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(userModel.toMap())
        .then(
      (value) {
        emit(RegisterCreateUserSuccessState(uID: userModel.uID));
        
      },
    ).catchError(
      (error) {
        emit(RegisterCreateUserErrorState(error: error));
      },
    );
  }
}
