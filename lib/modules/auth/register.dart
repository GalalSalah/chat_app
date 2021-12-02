import 'package:buildcondition/buildcondition.dart';
import 'package:chat_app/modules/auth/register_cubit/cubit.dart';
import 'package:chat_app/modules/auth/register_cubit/state.dart';
import 'package:chat_app/modules/home/home_screen.dart';
import 'package:chat_app/shared/component/components.dart';
import 'package:chat_app/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class ChatRegister extends StatelessWidget {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChatRegisterCubit(),
      child: BlocConsumer<ChatRegisterCubit, ChatRegisterStates>(
        listener: (context, state) {
          // if (state is ShopRegisterSuccessState) {
          //   else {
          //     print(state.loginModel.message);
          //     showToast(msg: state.loginModel.message, state: ToastState.error);
          //   }
          // }
          if (state is ChatCreateUserSuccessState) {
            navigateAndReplacement(context, HomeScreen());
          }
          // if (state is ChatRegisterSuccessState) {
          //   CashHelper.saveData(key: 'uid', value: state.uid).then((value) {
          //     navigateAndReplacement(context, HomeScreen());
          //   });
          //   // showToast(msg: state.loginModel.message, state: ToastState.success);
          //
          // }
        },
        builder: (context, state) {
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Register now to communicate our friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameEditingController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            } else {
                              return null;
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: emailEditingController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your email';
                            } else {
                              return null;
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneEditingController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your phone';
                            } else {
                              return null;
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          isPassword: ChatRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            ChatRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          controller: passwordEditingController,
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            // if (formKey.currentState.validate()) {
                            //   ShopRegisterCubit.get(context).userLogin(
                            //     email: emailEditingController.text,
                            //     password: passwordEditingController.text,
                            //   );
                            // }
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
                          suffix: ChatRegisterCubit.get(context).suffix,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BuildCondition(
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ChatRegisterCubit.get(context).userRegister(
                                  name: nameEditingController.text,
                                  phone: phoneEditingController.text,
                                  email: emailEditingController.text,
                                  password: passwordEditingController.text,
                                );
                              }
                            },
                            text: 'Register',
                            radius: 5,
                            isUpperCase: true,
                            background: Colors.teal,
                            width: double.infinity / 2,
                          ),
                          condition: state is! ChatRegisterLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text('Already have an account?'),
                            defaultTextButton(
                                fct: () =>
                                    navigateAndReplacement(context, ChatLoginScreen()),
                                label: 'Login')
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
