class PostModel {
  String name;
  String profileImage;
  String uID;
  String dateTime;
  String text;
  String? postImage;

  PostModel({
    required this.name,
    required this.profileImage,
    required this.uID,
    required this.dateTime,
    required this.text,
    this.postImage,
  });

  factory PostModel.fromJson(json) {
    return PostModel(
      name: json['name'],
      profileImage: json['profileImage'],
      uID: json['uID'],
      dateTime: json['dateTime'],
      text: json['text'],
      postImage: json['postImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileImage': profileImage,
      'uID': uID,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
