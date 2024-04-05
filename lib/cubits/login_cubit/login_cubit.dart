import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/cubits/login_cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
  IconData suffix = Icons.visibility_off_outlined;
  void changePasswordSuffixIcon() {
    isVisible = !isVisible;
    suffix =
        isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(LoginPasswordVisibilityState());
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessState(uID: user.user!.uid));
    } on FirebaseAuthException catch (error) {
      debugPrint('There was an authentication error ${error.code}');
      emit(LoginErrorState(error: error.toString()));
    } catch (error) {
      debugPrint('There was an error ${error.toString()}');
      emit(LoginErrorState(error: error.toString()));
    }
  }
}
