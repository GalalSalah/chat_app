import 'dart:io';
import 'package:chat_app/models/chat_message_models.dart';
import 'package:chat_app/models/post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/chat/chat_screen.dart';
import 'package:chat_app/modules/feeds/feeds_screen.dart';
import 'package:chat_app/modules/home/home_screen.dart';
import 'package:chat_app/modules/new_post/new_post_screen.dart';
import 'package:chat_app/modules/settings/settings_screen.dart';
import 'package:chat_app/modules/users/users_screen.dart';
import 'package:chat_app/shared/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ChatCubit extends Cubit<ChatAppStates> {
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);
  UserModel userModel;

  void getUserData() {
    emit(ChatGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      // print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(ChatGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ChatGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chat',
    'Post',
    'Users',
    'Setting',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(ChatNewPostState());
    } else {
      currentIndex = index;
      emit(ChatChangeNavBarState());
    }
  }

  File profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ChatProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ChatProfileImagePickedErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(ChatCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(ChatCoverImageErrorState());
    }
  }

  void uploadProfileImage(
      {@required String name, @required String phone, @required String bio}) {
    emit(ChatUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(ChatUploadProfileImageSuccessState());
        updateUser(bio: bio, name: name, phone: phone, image: value);
        print(value);
      }).catchError((e) {
        emit(ChatUploadProfileImageErrorState());
        print(e.toString());
      });
    }).catchError((error) {
      emit(ChatUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage(
      {@required String name, @required String phone, @required String bio}) {
    emit(ChatUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(ChatUploadCoverImageSuccessState());
        updateUser(bio: bio, name: name, phone: phone, cover: value);
        print(value);
      }).catchError((e) {
        emit(ChatUploadCoverImageErrorState());
        print(e.toString());
      });
    }).catchError((error) {
      emit(ChatUploadCoverImageErrorState());
    });
  }

  // void updateUserData(
  //     {@required String name, @required String phone, @required String bio}) {
  //   emit(ChatUserUpdateLoadingState());
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null && coverImage != null) {
  //   } else {
  //     updateUser(phone: phone, name: name, bio: bio);
  //   }
  // }

  void updateUser(
      {@required String name,
      @required String phone,
      @required String bio,
      String cover,
      String image}) {
    UserModel model = UserModel(
      phone: phone,
      name: name,
      uid: userModel.uid,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
      email: userModel.email,
      bio: bio,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((e) {
      emit(ChatUserUpdateErrorState());
    });
  }

  File postImageFile;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      postImageFile = File(pickedFile.path);
      emit(ChatPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ChatPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImageFile = null;
    emit(ChatRemovePostImageState());
  }

  void uploadPostImage({
    @required String dateTime,
    @required String postText,
  }) {
    emit(ChatCreateNewPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImageFile.path).pathSegments.last}')
        .putFile(postImageFile)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(postText: postText, dateTime: dateTime, postImage: value);
        emit(ChatCreateNewPostSuccessState());

        print(value);
      }).catchError((e) {
        print(e.toString());
        emit(ChatCreateNewPostErrorState());
      });
    }).catchError((error) {
      emit(ChatCreateNewPostErrorState());
    });
  }

  void createPost(
      {@required String dateTime,
      @required String postText,
      String postImage}) {
    emit(ChatCreateNewPostLoadingState());
    PostModel model = PostModel(
        name: userModel.name,
        uid: userModel.uid,
        image: userModel.image,
        postImage: postImage ?? '',
        dateTime: dateTime,
        postText: postText);
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(ChatCreateNewPostSuccessState());
    }).catchError((e) {
      emit(ChatCreateNewPostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(ChatGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          commentsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          // print('hiiii  ${element.id}');
        });
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          // print('hello  ${element.id}');
          // posts.add(PostModel.fromJson(element.data()));
        });
      });
      emit(ChatGetPostsSuccessState());
    }).catchError((error) {
      emit(ChatGetPostsErrorState(error.toString()));
    });
  }

  List<String> commentsId = [];
  List<int> comments = [];

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uid)
        .set({'like': true}).then((value) {
      emit(ChatLikePostsSuccessState());
    }).catchError((error) {
      emit(ChatLikePostsErrorState(error.toString()));
    });
  }

  void addCommentOnPost(String commentId, String commentContent) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(commentId)
        .collection('comments')
        .doc(userModel.uid)
        .set({'comment': commentContent}).then((value) {
      emit(ChatCommentPostsSuccessState());
    }).catchError((error) {
      emit(ChatCommentPostsErrorState(error));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    if (users.length == 0)
      // emit(ChatGetALLUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel.uid)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(ChatGetALLUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ChatGetALLUsersErrorState(error.toString()));
      });
  }

  void sendMessage(
      {@required String receiverId,
      @required String text,
      @required String dateTime}) {
    MessageModel model = MessageModel(
      dateTime: dateTime,
      text: text,
      receiverId: receiverId,
      senderId: userModel.uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uid)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatSendMessageErrorState());
    });
  }

  List<MessageModel> message = [];

  void getMessage({@required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message').orderBy('dateTime')
        .snapshots()
        .listen((event) {
          message=[];
      event.docs.forEach((element) {
        message.add(MessageModel.fromJson(element.data()));
      });
      emit(ChatGetAllMessageSuccessState());
    });
  }
}
