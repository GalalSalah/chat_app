class PostModel {
  String name;
  String dateTime;
  String postText;
  String uid;
  String postImage;
  String image;


  PostModel({this.name,this.uid, this.dateTime, this.postText, this.postImage,this.image
   });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    postText = json['postText'];
    uid = json['uid'];
    postImage=json['postImage'];
    image=json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'postText': postText,
      'uid': uid,
      'dateTime':dateTime,
      'image':image,

    };
  }
}
