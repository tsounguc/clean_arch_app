import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
}
