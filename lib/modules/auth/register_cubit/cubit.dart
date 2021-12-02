import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/auth/login_cubit/state.dart';
import 'package:chat_app/modules/auth/register_cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRegisterCubit extends Cubit<ChatRegisterStates> {
  ChatRegisterCubit() : super(ChatRegisterInitialState());

  static ChatRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(ChatRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value.credential.token);
      // print(value.user.email);
      // print(value.user.uid);
      createUser(
        uid: value.user.uid,
        name: name,
        phone: phone,
        email: email,
      );
    }).catchError((error) {
      print(error.toString());
      emit(ChatRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    @required String email,
    @required String uid,
    @required String name,
    @required String phone,
  }) {
    UserModel model = UserModel(
      email: email,
      phone: phone,
      name: name,
      image:'https://image.shutterstock.com/image-illustration/photo-silhouette-male-profile-white-260nw-1019597599.jpg',
     cover: 'https://image.freepik.com/free-psd/elegant-document-with-envelope-stationery-mockup_47987-3109.jpg',
      bio:'write your bio ....',
      uid: uid,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {

      emit(ChatCreateUserSuccessState());
    }).catchError((error) {
      print(model.uid);
      print(error.toString());
      emit(

        ChatCreateUserErrorState(error.toString()),

      );

    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChatRegisterChangePasswordVisibilityState());
  }
}
