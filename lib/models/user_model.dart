class UserModel {
  String name;
  String email;
  String phone;
  String uid;
  String image;
  String cover;
  String bio;
  bool isEmailVerified;

  UserModel({this.name,this.uid, this.email, this.phone, this.image,this.cover,this.bio,this.isEmailVerified});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uid = json['uid'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uid': uid,
      'image':image,
      'cover':cover,
      'bio':bio,
    'isEmailVerified':isEmailVerified,
    };
  }
}
