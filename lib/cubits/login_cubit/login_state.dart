abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uID;
  LoginSuccessState({required this.uID});
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState({required this.error});
}

class LoginPasswordVisibilityState extends LoginStates {}

