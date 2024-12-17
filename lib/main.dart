import 'package:clean_arch_app/core/services/service_locator.dart';
import 'package:clean_arch_app/features/user_profile/presentation/pages/user_profile_screen.dart';
import 'package:clean_arch_app/features/user_profile/presentation/user_profile_cubit/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main({bool runDependencies = true}) async {
  if (runDependencies) {
    await setUpDependencies();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => serviceLocator<UserProfileCubit>()..loadUserProfile('1'),
        child: const UserProfileScreen(),
      ),
    );
  }
}
