import 'package:flutter/material.dart';
import 'package:social_app/models/message_model.dart';

class BuildReceiverMessage extends StatelessWidget {
  final MessageModel messageModel;
  const BuildReceiverMessage({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (messageModel.messageImage != null)
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    messageModel.messageImage!,
                  ),
                ),
              ),
            ),
          if (messageModel.message != '')
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                ),
              ),
              child: Text(
                messageModel.message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class BuildSenderMessage extends StatelessWidget {
  final MessageModel messageModel;
  const BuildSenderMessage({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (messageModel.messageImage != null)
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    messageModel.messageImage!,
                  ),
                ),
              ),
            ),
          if (messageModel.message != '')
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.4),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                ),
              ),
              child: Text(
                messageModel.message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
