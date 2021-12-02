abstract class ChatAppStates{}
class ChatInitialState extends ChatAppStates{}
class ChatGetUserSuccessState extends ChatAppStates{}
class ChatGetUserLoadingState extends ChatAppStates{}
class ChatGetUserErrorState extends ChatAppStates{
  final String error;

  ChatGetUserErrorState(this.error);
}

class ChatGetALLUsersSuccessState extends ChatAppStates{}
class ChatGetALLUsersLoadingState extends ChatAppStates{}
class ChatGetALLUsersErrorState extends ChatAppStates{
  final String error;

  ChatGetALLUsersErrorState(this.error);
}

class ChatSendMessageSuccessState extends ChatAppStates{}
class ChatSendMessageErrorState extends ChatAppStates{}

class ChatGetAllMessageSuccessState extends ChatAppStates{}
class ChatGetAllMessageErrorState extends ChatAppStates{}

class ChatGetPostsSuccessState extends ChatAppStates{}
class ChatGetPostsLoadingState extends ChatAppStates{}
class ChatGetPostsErrorState extends ChatAppStates{
  final String error;

  ChatGetPostsErrorState(this.error);
}



class ChatLikePostsSuccessState extends ChatAppStates{}
class ChatLikePostsErrorState extends ChatAppStates{
  final String error;

  ChatLikePostsErrorState(this.error);
}
class ChatCommentPostsSuccessState extends ChatAppStates{}
class ChatCommentPostsErrorState extends ChatAppStates{
  final String error;

  ChatCommentPostsErrorState(this.error);
}
class ChatChangeNavBarState extends ChatAppStates{}
class ChatNewPostState extends ChatAppStates{}

class ChatProfileImagePickedSuccessState extends ChatAppStates{}
class ChatProfileImagePickedErrorState extends ChatAppStates{}

class ChatUploadProfileImageSuccessState extends ChatAppStates{}
class ChatUploadProfileImageErrorState extends ChatAppStates{}

class ChatCoverImageSuccessState extends ChatAppStates{}
class ChatCoverImageErrorState extends ChatAppStates{}
class ChatUploadCoverImageSuccessState extends ChatAppStates{}
class ChatUploadCoverImageErrorState extends ChatAppStates{}

class ChatUserUpdateErrorState extends ChatAppStates{}
class ChatUserUpdateLoadingState extends ChatAppStates{}


class ChatCreateNewPostErrorState extends ChatAppStates{}
class ChatCreateNewPostLoadingState extends ChatAppStates{}
class ChatCreateNewPostSuccessState extends ChatAppStates{}


class ChatPostImagePickedSuccessState extends ChatAppStates{}
class ChatPostImagePickedErrorState extends ChatAppStates{}


class ChatRemovePostImageState extends ChatAppStates{}