import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:chat_app/cubit/cubit.dart';
import 'package:chat_app/cubit/state.dart';
import 'package:chat_app/shared/component/components.dart';
import 'package:chat_app/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = ChatCubit.get(context).userModel;
        var profileImage = ChatCubit.get(context).profileImage;
        var coverImage = ChatCubit.get(context).coverImage;

        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                  fct: () {
                    ChatCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  label: 'UPDATE'),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is ChatUserUpdateLoadingState)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 190,
                  child: Stack(
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
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    topLeft: Radius.circular(4)),
                                image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            CircleAvatar(
                                radius: 18,
                                child: IconButton(
                                    onPressed: () {
                                      ChatCubit.get(context).getCoverImage();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    )))
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage),
                              ),
                            ),
                          ),
                          CircleAvatar(
                              radius: 18,
                              child: IconButton(
                                  onPressed: () {
                                    ChatCubit.get(context).getProfileImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 16,
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (ChatCubit.get(context).profileImage != null ||
                    ChatCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if (ChatCubit.get(context).profileImage != null)
                        Expanded(
                            child: Column(
                          children: [
                            defaultButton(
                                function: () {
                                  ChatCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                text: 'Upload Profile'),
                            if (state is ChatUserUpdateLoadingState)
                              SizedBox(
                                height: 5,
                              ),
                            if (state is ChatUserUpdateLoadingState)
                              LinearProgressIndicator(),
                          ],
                        )),
                      SizedBox(
                        width: 8,
                      ),
                      if (ChatCubit.get(context).coverImage != null)
                        Expanded(
                            child: Column(
                          children: [
                            defaultButton(
                                function: () {
                                  ChatCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                text: 'Upload Cover'),
                            if (state is ChatUserUpdateLoadingState)
                              SizedBox(
                                height: 5,
                              ),
                            if (state is ChatUserUpdateLoadingState)
                              LinearProgressIndicator(),
                          ],
                        )),
                    ],
                  ),
               const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    label: 'Update your name',
                    prefix: IconBroken.User),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'bio must not be empty';
                      } else {
                        return null;
                      }
                    },
                    label: 'Update your bio',
                    prefix: IconBroken.Info_Circle),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Phone Number must not be empty';
                      } else {
                        return null;
                      }
                    },
                    label: 'Update your phone',
                    prefix: IconBroken.Call),
              ],
            ),
          ),
        );
      },
    );
  }
}
