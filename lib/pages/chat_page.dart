import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/social_cubit/social_cubit.dart';
import 'package:social_app/cubits/social_cubit/social_state.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/widgets/build_message.dart';
import 'package:social_app/widgets/custom_user_widget.dart';

class ChatPage extends StatefulWidget {
  final UserModel userModel;

  const ChatPage({super.key, required this.userModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context)
            .getAllMessages(receiverID: widget.userModel.uID);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            if (state is SendMessageSuccessState) scroll();
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: UserWidget(
                  image: widget.userModel.image,
                  name: widget.userModel.name,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SocialCubit.get(context).messages.isNotEmpty &&
                            SocialCubit.get(context).userModel != null
                        ? Expanded(
                            child: ListView.separated(
                              reverse: true,
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemBuilder: (context, index) {
                                if (SocialCubit.get(context).userModel!.uID ==
                                    SocialCubit.get(context)
                                        .messages[index]
                                        .senderID) {
                                  return BuildSenderMessage(
                                    messageModel: SocialCubit.get(context)
                                        .messages[index],
                                  );
                                } else {
                                  return BuildReceiverMessage(
                                    messageModel: SocialCubit.get(context)
                                        .messages[index],
                                  );
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 15,
                                );
                              },
                              itemCount:
                                  SocialCubit.get(context).messages.length,
                            ),
                          )
                        : SocialCubit.get(context).messages.isEmpty
                            ? const Spacer()
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (SocialCubit.get(context).messageImageURL != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  SocialCubit.get(context).messageImageURL!,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              SocialCubit.get(context).removeMessageImage();
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message here...',
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).getMessageImage();
                              },
                              minWidth: 1,
                              child: const Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverID: widget.userModel.uID,
                                  message: messageController.text,
                                );
                                messageController.clear();
                                SocialCubit.get(context).removeMessageImage();
                              },
                              minWidth: 1,
                              child: const Icon(
                                Icons.send,
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void scroll() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
