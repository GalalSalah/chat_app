import 'package:chat_app/modules/auth/register.dart';
import 'package:chat_app/modules/home/home_screen.dart';
import 'package:chat_app/shared/component/components.dart';
import 'package:chat_app/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';


import 'package:buildcondition/buildcondition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_cubit/cubit.dart';
import 'login_cubit/state.dart';

class ChatLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=>ChatLoginCubit(),
      child: BlocConsumer<ChatLoginCubit,ChatLoginStates>(
   listener: (context,state){
     if(state is ChatLoginErrorState){
       showToast(msg: state.error, state: ToastState.error);
     }
     if (state is ChatLoginSuccessState) {
       CashHelper.saveData(key: 'uid', value: state.uid).then((value) {
         navigateAndReplacement(context, HomeScreen());
       });
       // showToast(msg: state.loginModel.message, state: ToastState.success);

     }
   },
        builder: (context,state){
     return Scaffold(
       appBar: AppBar(),
       body: Center(
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Form(
               key: formKey,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'LOGIN',
                     style: Theme
                         .of(context)
                         .textTheme
                         .headline5,
                   ),
                   Text(
                     'Login now to communicate our friends',
                     style: Theme
                         .of(context)
                         .textTheme
                         .bodyText1
                         .copyWith(color: Colors.grey),
                   ),
                   const SizedBox(
                     height: 30,
                   ),
                   defaultFormField(
                     controller: emailEditingController,
                     type: TextInputType.emailAddress,
                     validate: (value) {
                       if (value.isEmpty) {
                         return 'please enter your email address';
                       }
                       // else{
                       //   return null;
                       // }
                     },
                     label: 'Email Address',
                     prefix: Icons.email,
                   ),
                   SizedBox(
                     height: 15,
                   ),
                   defaultFormField(
                     isPassword: ChatLoginCubit
                         .get(context)
                         .isPassword,
                     suffixPressed: () {
                       ChatLoginCubit.get(context)
                           .changePasswordVisibility();
                     },
                     controller: passwordEditingController,
                     type: TextInputType.visiblePassword,
                     onSubmit: (value) {
                       if (formKey.currentState.validate()) {
                         ChatLoginCubit.get(context).userLogin(
                           email: emailEditingController.text,
                           password: passwordEditingController.text,
                         );
                       }
                     },
                     validate: (String value) {
                       if (value.isEmpty) {
                         return 'password is too short';
                       } else {
                         return null;
                       }
                     },
                     label: 'Password',
                     prefix: Icons.lock,
                     suffix: ChatLoginCubit
                         .get(context)
                         .suffix,
                   ),
                   const SizedBox(
                     height: 30,
                   ),
                   BuildCondition(
                     builder: (context) =>
                         defaultButton(
                           function: () {
                             if (formKey.currentState.validate()) {
                               ChatLoginCubit.get(context).userLogin(
                                 email: emailEditingController.text,
                                 password: passwordEditingController.text,
                               );
                             }
                           },
                           text: 'LOGIN',
                           radius: 5,
                           isUpperCase: true,
                           background: Colors.teal,
                           width: double.infinity / 2,
                         ),
                     condition: state is! ChatLoginLoadingState,
                     fallback: (context) =>
                     const Center(
                       child: CircularProgressIndicator(),
                     ),
                   ),
                   const SizedBox(
                     height: 15,
                   ),
                   Row(
                     children: [
                       const Text('Don\'t have an account?'),
                       defaultTextButton(
                           fct: () =>
                               navigateTo(context, ChatRegister()),
                           label: 'register')
                     ],
                   )
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
