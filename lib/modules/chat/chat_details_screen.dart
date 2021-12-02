import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/cubit/state.dart';
import 'package:chat_app/models/chat_message_models.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/style/color.dart';
import 'package:chat_app/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:bloc/bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen({this.userModel});

  TextEditingController sendMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        ChatCubit.get(context).getMessage(receiverId: userModel.uid);

        return BlocConsumer<ChatCubit, ChatAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){Navigator.pop(context);},
                icon: Icon(IconBroken.Arrow___Left,color: Colors.black,),),
              titleSpacing: 0.0,
              title: Row(

                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${userModel.image}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(userModel.name),
                ],
              ),
            ),
            body: BuildCondition(
              condition:ChatCubit.get(context).message.length>0 ,
              fallback:(context)=>Center(child: CircularProgressIndicator()) ,
              builder: (context)=> Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index){
                        var message=ChatCubit.get(context).message[index];
                        if(ChatCubit.get(context).userModel.uid==message.senderId) {
                          return buildMyMessage(message);
                        }
                      return  buildMessage(message);
                      },
                          separatorBuilder: (context,index)=>SizedBox(height: 10,),
                          itemCount: ChatCubit.get(context).message.length),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                controller: sendMessageController,
                                decoration: const InputDecoration(
                                  hintText: 'type your message here...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: defaultColor,
                            height: 49,
                            child: MaterialButton(
                              onPressed: () {
                                ChatCubit.get(context).sendMessage(
                                  receiverId: userModel.uid,
                                  text: sendMessageController.text,
                                  dateTime: DateTime.now().toString(),
                                );
                                sendMessageController.clear();
                              },
                              minWidth: 1,
                              child: Icon(
                                IconBroken.Send,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

            ),
          );
        },
      );},

    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text(model.text),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text(model.text),
        ),
      );
}
