abstract class SocialStates {}

class SocialInitState extends SocialStates {}

class GetUserLoadingState extends SocialStates {}

class GetUserSuccessState extends SocialStates {}

class GetUserErrorState extends SocialStates {
  final String error;
  GetUserErrorState({required this.error});
}

class ChangeBotNavState extends SocialStates {}

class PickedProfileImageSuccessState extends SocialStates {}

class PickedProfileImageErrorState extends SocialStates {}

class PickedCoverImageSuccessState extends SocialStates {}

class PickedCoverImageErrorState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class UserUpdateLoadingState extends SocialStates {}

class UserUpdateSuccessState extends SocialStates {}

class UserUpdateErrorState extends SocialStates {}

class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

class PickedPostImageSuccessState extends SocialStates {}

class PickedPostImageErrorState extends SocialStates {}

class UploadPostImageSuccessState extends SocialStates {}

class UploadPostImageErrorState extends SocialStates {}

class RemovePostImageState extends SocialStates {}

class GetPostsLoadingState extends SocialStates {}

class GetPostsSuccessState extends SocialStates {}

class GetPostsErrorState extends SocialStates {}

class GetAllUsersLoadingState extends SocialStates {}

class GetAllUsersSuccesState extends SocialStates {}

class GetAllUsersErrorState extends SocialStates {}

class SignOutLoadingState extends SocialStates {}

class SignOutSuccessState extends SocialStates {}

class SignOutErrorState extends SocialStates {}

class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class GetAllMessagesSuccessState extends SocialStates {}

class PickedMessageImageSuccessState extends SocialStates {}

class PickedMessageImageErrorState extends SocialStates {}

class UploadMessageImageSuccessState extends SocialStates {}

class UploadMessageImageErrorState extends SocialStates {}

class RemoveMessageImageState extends SocialStates {}
