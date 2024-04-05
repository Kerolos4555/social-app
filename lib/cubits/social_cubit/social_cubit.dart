import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:social_app/cubits/social_cubit/social_state.dart';
import 'package:social_app/helper/cached_helper.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/users_page.dart';
import 'package:social_app/pages/feeds_page.dart';
import 'package:social_app/pages/settings_page.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserData({required String id}) {
    emit(GetUserLoadingState());
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      user == null
          ? debugPrint('user is currently singout!')
          : debugPrint('User is signed in!');
    });
    FirebaseFirestore.instance.collection('users').doc(id).get().then(
      (value) {
        userModel = UserModel.fromJson(value.data());
        emit(GetUserSuccessState());
      },
    ).catchError(
      (error) {
        debugPrint('There was an error when get user data ${error.toString()}');
        emit(GetUserErrorState(error: error.toString()));
      },
    );
  }

  int currentIndex = 0;
  List<Widget> pages = const [
    FeedsPage(),
    UsersPage(),
    SettingsPage(),
  ];
  List<String> titles = const [
    'Home',
    'All Users',
    'Settings',
  ];
  void changeBotNav(int index) {
    if (index == 1) {
      emit(GetAllUsersLoadingState());
      getUsers();
    }
    currentIndex = index;
    emit(ChangeBotNavState());
  }

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        uploadProfileImage();
      } else {
        debugPrint('no image selected.');
      }
      emit(PickedProfileImageSuccessState());
    } catch (error) {
      debugPrint('There was an error ${error.toString()}');
      emit(PickedProfileImageErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        coverImage = File(pickedFile.path);
        uploadCoverImage();
      } else {
        debugPrint('no image selected.');
      }
      emit(PickedCoverImageSuccessState());
    } catch (error) {
      debugPrint('There was an error ${error.toString()}');
      emit(PickedCoverImageErrorState());
    }
  }

  String profileImageURL = '';
  void uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(profileImage!.path).pathSegments.last}',
        )
        .putFile(profileImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            profileImageURL = value;
            emit(UploadProfileImageSuccessState());
          },
        ).catchError(
          (error) {
            debugPrint('There was an error when download profile image');
            emit(UploadProfileImageErrorState());
          },
        );
      },
    ).catchError(
      (error) {
        debugPrint('There was an error when get the profile image path');
        emit(UploadProfileImageErrorState());
      },
    );
  }

  String coverImageURL = '';
  void uploadCoverImage() {
    FirebaseStorage.instance
        .ref()
        .child(
          'users/${Uri.file(coverImage!.path).pathSegments.last}',
        )
        .putFile(coverImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            debugPrint(value);
            coverImageURL = value;
            emit(UploadCoverImageSuccessState());
          },
        ).catchError(
          (error) {
            debugPrint('There was an error when download Cover image');
            emit(UploadCoverImageErrorState());
          },
        );
      },
    ).catchError(
      (error) {
        debugPrint('There was an error when get the Cover image path');
        emit(UploadCoverImageErrorState());
      },
    );
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());
    UserModel model = UserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uID: userModel!.uID,
      image: profileImageURL == '' ? userModel!.image : profileImageURL,
      bio: bio,
      coverImage: coverImageURL == '' ? userModel!.coverImage : coverImageURL,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID)
        .update(model.toMap())
        .then(
      (value) {
        emit(UserUpdateSuccessState());
        getUserData(id: userModel!.uID);
      },
    ).catchError(
      (error) {
        debugPrint('There was an error when updating user data');
        emit(UserUpdateErrorState());
      },
    );
  }

  File? postImage;
  Future<void> getPostImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        postImage = File(pickedFile.path);
        uploadPostImage();
      } else {
        debugPrint('no image selected.');
      }
      emit(PickedPostImageSuccessState());
    } catch (error) {
      debugPrint('There was an error ${error.toString()}');
      emit(PickedPostImageErrorState());
    }
  }

  String? postImageURL;
  void uploadPostImage() {
    FirebaseStorage.instance
        .ref()
        .child(
          'posts/${Uri.file(postImage!.path).pathSegments.last}',
        )
        .putFile(postImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            debugPrint(value);
            postImageURL = value;
            emit(UploadPostImageSuccessState());
          },
        ).catchError(
          (error) {
            debugPrint('There was an error when download post image');
            emit(UploadPostImageErrorState());
          },
        );
      },
    ).catchError(
      (error) {
        debugPrint('There was an error when get the post image path');
        emit(UploadPostImageErrorState());
      },
    );
  }

  void createNewPost({
    required String text,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      profileImage: userModel!.image,
      uID: userModel!.uID,
      dateTime: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
      text: text,
      postImage: postImageURL,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(
          model.toMap(),
        )
        .then(
      (value) {
        getPosts();
        emit(CreatePostSuccessState());
      },
    ).catchError(
      (error) {
        debugPrint('There was an erro when create user ${error.toString()}');
        emit(CreatePostErrorState());
      },
    );
  }

  void removePostImage() {
    postImage = null;
    postImageURL = null;
    emit(RemovePostImageState());
  }

  late List<PostModel> posts;
  List<String> postsID = [];
  void getPosts() {
    emit(GetPostsLoadingState());
    posts = [];
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy(
          'dateTime',
          descending: true,
        )
        .get()
        .then(
      (value) {
        for (var element in value.docs) {
          posts.add(PostModel.fromJson(element.data()));
          postsID.add(element.id);
        }
        emit(GetPostsSuccessState());
      },
    ).catchError(
      (error) {
        debugPrint('There was an error when get posts ${error.toString()}');
        emit(GetPostsErrorState());
      },
    );
  }

  late List<UserModel> users;
  void getUsers() {
    emit(GetAllUsersLoadingState());
    users = [];
    FirebaseFirestore.instance.collection('users').get().then(
      (value) {
        for (var element in value.docs) {
          users.add(UserModel.fromJson(element.data()));
        }
        emit(GetAllUsersSuccesState());
      },
    ).catchError(
      (error) {
        debugPrint(
            'There was an error when getting all users ${error.toString()}');
        emit(GetAllUsersErrorState());
      },
    );
  }

  void signOut() {
    emit(SignOutLoadingState());
    FirebaseAuth.instance.signOut().then(
      (value) {
        CachedHelper.removeData(
          key: 'uID',
        ).then(
          (value) {
            emit(SignOutSuccessState());
          },
        ).catchError(
          (error) {
            debugPrint(
                'There was an error when remove user id ${error.toString()}');
            emit(SignOutErrorState());
          },
        );
      },
    ).catchError(
      (error) {
        debugPrint('There was an error when you sign out ${error.toString()}');
        emit(SignOutErrorState());
      },
    );
  }

  File? messageImage;
  Future<void> getMessageImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        messageImage = File(pickedFile.path);
        uploadMessageImage();
      } else {
        debugPrint('no image selected.');
      }
      emit(PickedMessageImageSuccessState());
    } catch (error) {
      debugPrint('There was an error ${error.toString()}');
      emit(PickedMessageImageErrorState());
    }
  }

  String? messageImageURL;
  void uploadMessageImage() {
    FirebaseStorage.instance
        .ref()
        .child(
          'messages/${Uri.file(messageImage!.path).pathSegments.last}',
        )
        .putFile(messageImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            debugPrint(value);
            messageImageURL = value;
            emit(UploadMessageImageSuccessState());
          },
        ).catchError(
          (error) {
            debugPrint('There was an error when download message image');
            emit(UploadMessageImageErrorState());
          },
        );
      },
    ).catchError(
      (error) {
        debugPrint('There was an error when get the message image path');
        emit(UploadMessageImageErrorState());
      },
    );
  }

  void removeMessageImage() {
    messageImage = null;
    messageImageURL = null;
    emit(RemoveMessageImageState());
  }

  void sendMessage({
    required String receiverID,
    required String message,
  }) {
    MessageModel model = MessageModel(
      senderID: userModel!.uID,
      receiverID: receiverID,
      message: message,
      dateTime: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
      messageImage: messageImageURL,
    );
    if (message != '' || messageImageURL != null) {
      if (userModel!.uID == receiverID) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uID)
            .collection('chat')
            .doc(receiverID)
            .collection('messages')
            .add(model.toMap())
            .then(
          (value) {
            emit(SendMessageSuccessState());
          },
        ).catchError(
          (error) {
            debugPrint(
                'There was an error when sending a message ${error.toString()}');
            emit(SendMessageErrorState());
          },
        );
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uID)
            .collection('chat')
            .doc(receiverID)
            .collection('messages')
            .add(model.toMap())
            .then(
          (value) {
            emit(SendMessageSuccessState());
          },
        ).catchError(
          (error) {
            debugPrint(
                'There was an error when sending a message ${error.toString()}');
            emit(SendMessageErrorState());
          },
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(receiverID)
            .collection('chat')
            .doc(userModel!.uID)
            .collection('messages')
            .add(model.toMap())
            .then(
          (value) {
            emit(SendMessageSuccessState());
          },
        ).catchError(
          (error) {
            debugPrint(
                'There was an error when sending a message ${error.toString()}');
            emit(SendMessageErrorState());
          },
        );
      }
    }
  }

  List<MessageModel> messages = [];
  void getAllMessages({
    required String receiverID,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID)
        .collection('chat')
        .doc(receiverID)
        .collection('messages')
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots()
        .listen(
      (event) {
        messages = [];
        for (var element in event.docs) {
          messages.add(MessageModel.fromJson(element.data()));
        }
        emit(GetAllMessagesSuccessState());
      },
    );
  }
}
