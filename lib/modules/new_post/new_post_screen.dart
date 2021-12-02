import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/cubit/state.dart';
import 'package:chat_app/shared/component/components.dart';
import 'package:chat_app/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(fct: () {
                if (ChatCubit
                    .get(context)
                    .postImageFile != null) {
                  ChatCubit.get(context).uploadPostImage(
                      dateTime: DateTime.now().toString(),
                      postText: postController.text);
                } else {
                  ChatCubit.get(context).createPost(
                      dateTime: DateTime.now().toString(),
                      postText: postController.text);
                }
              }, label: 'Post'),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is ChatCreateNewPostLoadingState)
                  LinearProgressIndicator(),
                if(state is ChatCreateNewPostLoadingState)
                  SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/portrait-young-beautiful-playful-woman-with-bun-posing_176420-12392.jpg'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Galal Salah',
                        style: TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Text('What is on your mind,'),),
                  ),
                ),

               if(ChatCubit.get(context).postImageFile !=null)
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image:  FileImage(ChatCubit.get(context).postImageFile),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          CircleAvatar(
                              radius: 18,
                              child: IconButton(
                                  onPressed: () {
                                    ChatCubit.get(context).removePostImage();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    size: 16,
                                  )))
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: () {
                        ChatCubit.get(context).getPostImage();
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Image),
                          SizedBox(width: 5,),
                          Text('add a photo'),
                        ],)),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {

                          }, child: Text('# tags')),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
