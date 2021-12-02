import 'package:chat_app/modules/auth/login_cubit/state.dart';
import 'package:chat_app/modules/auth/register_cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatLoginCubit extends Cubit<ChatLoginStates> {
  ChatLoginCubit() : super(ChatLoginInitialState());

  static ChatLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({@required String email, @required String password}) {
    emit(ChatLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value.credential.token);
      print(value.user.email);
      print(value.user.uid);
      emit(ChatLoginSuccessState(value.user.uid));
    }).catchError((error) {
      print(error.toString());
      emit(ChatLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChatLoginChangePasswordVisibilityState());
  }
}
