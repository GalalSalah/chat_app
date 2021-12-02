import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/cubit/state.dart';
import 'package:chat_app/models/post_model.dart';
import 'package:chat_app/shared/component/components.dart';
import 'package:chat_app/shared/style/color.dart';
import 'package:chat_app/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/services.dart';

class FeedsScreen extends StatelessWidget {
  TextEditingController commentController = TextEditingController();
  FocusNode focusNode =  FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatAppStates>(
      listener: (context, state) {
        if(state is ChatCommentPostsSuccessState){
          showToast(msg: 'Your comment send Successfully',
              state: ToastState.success);
          // to hide keyboard after send your comment
         SystemChannels.textInput.invokeMethod('TextInput.hide');
          commentController.clear();
        }
      },
      builder: (context, state) {
        return BuildCondition(
          condition: ChatCubit.get(context).userModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  margin: EdgeInsets.all(10),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildPostItem(
                        ChatCubit.get(context).posts[index], context, index),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: ChatCubit.get(context).posts.length),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(height: 1.4),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(height: 1.4),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: double.infinity,
                child: Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
            ),
            Text(
              '${model.postText}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // SizedBox(height: 10,),
            // Padding(
            //   padding: const EdgeInsets.only(top: 5, bottom: 10),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 1),
            //           child: Container(
            //             height: 25,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               minWidth: 1,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                 '#software',
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .caption
            //                     .copyWith(color: defaultColor),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 1),
            //           child: Container(
            //             height: 25,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               minWidth: 1,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                 '#Dart',
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .caption
            //                     .copyWith(color: defaultColor),
            //               ),
            //             ),
            //           ),
            //         ),
            //         // Padding(
            //         //   padding: const EdgeInsetsDirectional.only(end: 3),
            //         //   child: Container(
            //         //     height: 25,
            //         //     child: MaterialButton(
            //         //       onPressed: () {},
            //         //       minWidth: 1,
            //         //       padding: EdgeInsets.zero,
            //         //       child: Text(
            //         //         '#IT',
            //         //         style: Theme.of(context).textTheme.caption.copyWith(color: defaultColor),
            //         //       ),
            //         //     ),
            //         //   ),
            //         // ),
            //         // Padding(
            //         //   padding: const EdgeInsetsDirectional.only(end: 3),
            //         //   child: Container(
            //         //     height: 25,
            //         //     child: MaterialButton(
            //         //       onPressed: () {},
            //         //       minWidth: 1,
            //         //       padding: EdgeInsets.zero,
            //         //       child: Text(
            //         //         '#flutter',
            //         //         style: Theme.of(context).textTheme.caption.copyWith(color: defaultColor),
            //         //       ),
            //         //     ),
            //         //   ),
            //         // ),
            //         // Padding(
            //         //   padding: const EdgeInsetsDirectional.only(end: 3),
            //         //   child: Container(
            //         //     height: 25,
            //         //     child: MaterialButton(
            //         //       onPressed: () {},
            //         //       minWidth: 1,
            //         //       padding: EdgeInsets.zero,
            //         //       child: Text(
            //         //         '#software',
            //         //         style: Theme.of(context).textTheme.caption.copyWith(color: defaultColor),
            //         //       ),
            //         //     ),
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${ChatCubit.get(context).likes[index]}'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.blue,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${ChatCubit.get(context).comments[index]}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: double.infinity,
                child: Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 0,
                          child: CircleAvatar(
                            radius: 17,
                            backgroundImage: NetworkImage(
                                ChatCubit.get(context).userModel.image),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        // Text(
                        //   'write a comment....',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .caption,
                        // ),
                        Expanded(
                          // flex: 2,
                          child: TextFormField(

                            controller: commentController,
                              // focusNode: FocusScope.of(context).requestFocus(FocusNode()),
                            onEditingComplete: (){
                              if(commentController.text.isEmpty){
                                return showToast(msg: 'Please write a comment',
                                    state: ToastState.success);
                              }else {
                                ChatCubit.get(context)
                                    .addCommentOnPost(
                                    ChatCubit
                                        .get(context)
                                        .commentsId[index],
                                    commentController.text);
                              }; },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              // border:  OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(8)) ),
                              label: Text('Write your comment '),

                            ),
                            // focusNode: ,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 0,
                  child: InkWell(
                    onTap: () {
                      ChatCubit.get(context)
                          .likePost(ChatCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Like'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}
