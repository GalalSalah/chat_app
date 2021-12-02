import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/cubit/state.dart';
import 'package:chat_app/modules/new_post/new_post_screen.dart';
import 'package:chat_app/shared/component/components.dart';
import 'package:chat_app/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatAppStates>(
      listener: (context, state) {
        if(state is ChatNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = ChatCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text (cubit.titles[cubit.currentIndex]),
            actions: [IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),

              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                label: 'Chats',
                icon: Icon(IconBroken.Chat),
              ),
              BottomNavigationBarItem(
                label: 'Post',
                icon: Icon(IconBroken.Paper_Upload),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(IconBroken.Setting),
              ),
            ],
          ),
        );
      },
    );
  }
}
// BuildCondition(
// condition: ChatCubit.get(context).model !=null,
// builder: (context){
// var model= ChatCubit.get(context).model;
// return Column(children: [
// if(!FirebaseAuth.instance.currentUser.emailVerified)Container(
// color: Colors.amberAccent.withOpacity(.7),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// child: Row(children:  [
// const Icon(Icons.warning_amber_rounded),
// const Expanded(
// child: Text('Please verified your email'),
// ),
// SizedBox(width: 20,),
// // defaultTextButton(function: (){}, text: 'SEND VERIFICATION',width: 115),
// defaultTextButton(fct: (){
// FirebaseAuth.instance.currentUser.sendEmailVerification().then((value) {
// showToast(msg: 'check your mail', state: ToastState.success);
// }).catchError((e){print(e.toString());});
// }, label: 'SEND VERIFICATION')
// ],),
// ),
// )
// ],);
// },
// fallback: (context)=> Center(child: CircularProgressIndicator()),
// )
