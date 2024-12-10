part of 'user_profile_cubit.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class UserProfileInitial extends UserProfileState {
  const UserProfileInitial();
}

final class LoadingUserProfile extends UserProfileState {
  const LoadingUserProfile();
}

final class UserProfileLoaded extends UserProfileState {
  const UserProfileLoaded({required this.user});
  final User user;
}

final class UserProfileError extends UserProfileState {
  const UserProfileError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
