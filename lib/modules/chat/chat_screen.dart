import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/cubit/state.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/chat/chat_details_screen.dart';
import 'package:chat_app/shared/component/components.dart';
import 'package:chat_app/shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:buildcondition/buildcondition.dart';
class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit,ChatAppStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return BuildCondition(
        condition:ChatCubit.get(context).users.length>0 ,
        builder: (context)=>ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildChatItem(ChatCubit.get(context).users[index],context),
            separatorBuilder:(context,index)=> Divider(thickness: 1,color: Colors.grey,),
            itemCount: ChatCubit.get(context).users.length),
        fallback:  (context)=>const Center(child:  CircularProgressIndicator()),
      );
    }
    );
  }
  Widget buildChatItem(UserModel model,context)=>   InkWell(
    onTap: (){navigateTo(context, ChatDetailsScreen(userModel: model,));},
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(model.image),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      model.name,
                      // style: const TextStyle(height: 1.4),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: defaultColor,
                      size: 16,
                    )
                  ],
                ),

              ],
            ),
          ),
          // SizedBox(
          //   width: 15,
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.more_horiz,
          //     size: 16,
          //   ),
          // ),
        ],
      ),
    ),
  );
}
