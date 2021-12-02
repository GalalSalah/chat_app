abstract class ChatRegisterStates {}

class ChatRegisterInitialState extends ChatRegisterStates {}

class ChatRegisterSuccessState extends ChatRegisterStates {
  // final String uid;
  //
  // ChatRegisterSuccessState(this.uid);
}

class ChatRegisterLoadingState extends ChatRegisterStates {}

class ChatRegisterErrorState extends ChatRegisterStates {
  final String error;

  ChatRegisterErrorState(this.error);
}

class ChatCreateUserSuccessState extends ChatRegisterStates {
  // final String uid;
  //
  // ChatCreateUserSuccessState(this.uid);

}
class ChatCreateUserErrorState extends ChatRegisterStates {
  final String error;

  ChatCreateUserErrorState(this.error);
}
class ChatRegisterChangePasswordVisibilityState extends ChatRegisterStates {}
