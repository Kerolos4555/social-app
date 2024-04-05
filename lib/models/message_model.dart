class MessageModel {
  String senderID;
  String receiverID;
  String message;
  String dateTime;
  String? messageImage;

  MessageModel({
    required this.senderID,
    required this.receiverID,
    required this.message,
    required this.dateTime,
    this.messageImage,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
      senderID: json['senderID'],
      receiverID: json['receiverID'],
      message: json['message'],
      dateTime: json['dateTime'],
      messageImage: json['messageImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'message': message,
      'dateTime': dateTime,
      'messageImage': messageImage,
    };
  }
}
