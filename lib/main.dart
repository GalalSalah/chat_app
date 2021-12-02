import 'package:chat_app/cubit/state.dart';
import 'package:chat_app/modules/auth/login.dart';
import 'package:chat_app/modules/home/home_screen.dart';
import 'package:chat_app/shared/bloc_observe.dart';
import 'package:chat_app/shared/component/components.dart';
import 'package:chat_app/shared/component/constant.dart';
import 'package:chat_app/shared/network/local/cash_helper.dart';
import 'package:chat_app/shared/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'cubit/cubit.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showToast(msg: 'on message background', state: ToastState.success);
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var getToken = await FirebaseMessaging.instance.getToken();
  print(getToken);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(msg: 'on message', state: ToastState.success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(msg: 'on message opened app', state: ToastState.success);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  // DioHelpers.init();
  await CashHelper.init();
  // bool isDark = CashHelper.getData(key: 'isDark');
  // bool onBoarding = CashHelper.getData(key: 'onBoarding');
  // String token = CashHelper.getData(key: 'token');
   uid = CashHelper.getData(key: 'uid');
  print(uid);

  Widget widget;

  if (uid != null) {
    widget = HomeScreen();
  } else {
    widget = ChatLoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
  // isDark!
}

class MyApp extends StatelessWidget {
  MyApp(
      {
      // required this.isDark,
      @required this.startWidget});

  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ChatCubit()..getUserData()..getPosts(),
      child: BlocConsumer<ChatCubit,ChatAppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(),
            debugShowCheckedModeBanner: false,
          darkTheme: lightTheme,
            home: startWidget,
          );
        },

      ),
    );
  }
}
