abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState({required this.error});
}

class RegisterCreateUserSuccessState extends RegisterStates {
  final String uID;
  RegisterCreateUserSuccessState({required this.uID});
}

class RegisterCreateUserErrorState extends RegisterStates {
  final String error;
  RegisterCreateUserErrorState({required this.error});
}

class RegisterPasswordVisibilityState extends RegisterStates {}
