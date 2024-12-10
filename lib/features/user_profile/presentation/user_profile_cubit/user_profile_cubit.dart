import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';
import 'package:clean_arch_app/features/user_profile/domain/use_cases/get_user.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({
    required GetUserProfile getUserProfile,
  })  : _getUserProfile = getUserProfile,
        super(const UserProfileInitial());
  final GetUserProfile _getUserProfile;

  Future<void> loadUserProfile(String userId) async {
    emit(const LoadingUserProfile());
    final result = await _getUserProfile(userId);

    result.fold(
      (failure) => emit(UserProfileError(message: failure.message)),
      (user) => emit(UserProfileLoaded(user: user)),
    );
  }
}
