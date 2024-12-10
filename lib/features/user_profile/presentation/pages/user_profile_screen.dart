import 'package:clean_arch_app/features/user_profile/presentation/user_profile_cubit/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileInitial || state is LoadingUserProfile) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserProfileError) {
            return Center(child: Text(state.message));
          } else {
            final user = (state as UserProfileLoaded).user;
            return Center(child: Text('Hello, ${user.name}!'));
          }
        },
      ),
    );
  }
}
