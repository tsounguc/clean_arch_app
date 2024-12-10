part of 'user_profile_cubit.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();
}

final class UserProfileInitial extends UserProfileState {
  @override
  List<Object> get props => [];
}
