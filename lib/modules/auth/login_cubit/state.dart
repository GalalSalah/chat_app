
abstract class ChatLoginStates{}
class ChatLoginInitialState extends ChatLoginStates{}
class ChatLoginSuccessState extends ChatLoginStates{
  final String uid;

  ChatLoginSuccessState(this.uid);
  // final  ShopLoginModel loginModel;
  // ShopLoginSuccessState(this.loginModel);
}
class ChatLoginLoadingState extends ChatLoginStates{}
class ChatLoginErrorState extends ChatLoginStates{
  final String error;
  ChatLoginErrorState(this.error);
}
class ChatLoginChangePasswordVisibilityState extends ChatLoginStates{}