class UserModel {
  final String name;
  final String email;
  final String phone;
  final String uID;
  final String image;
  final String coverImage;
  final String bio;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uID,
    required this.image,
    required this.bio,
    required this.coverImage,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      uID: json['uID'],
      image: json['image'],
      bio: json['bio'],
      coverImage: json['coverImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uID': uID,
      'image': image,
      'bio': bio,
      'coverImage': coverImage,
    };
  }
}
