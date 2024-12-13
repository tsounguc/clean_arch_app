import 'package:clean_arch_app/features/user_profile/data/data_sources/user_remote_data_source.dart';
import 'package:clean_arch_app/features/user_profile/data/repositories/user_repository_impl.dart';
import 'package:clean_arch_app/features/user_profile/domain/repositories/user_repository.dart';
import 'package:clean_arch_app/features/user_profile/domain/use_cases/get_user_profile.dart';
import 'package:clean_arch_app/features/user_profile/presentation/user_profile_cubit/user_profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final serviceLocator = GetIt.instance;

Future<void> setUpDependencies() async {
  // App Logic
  serviceLocator.registerFactory(() => UserProfileCubit(getUserProfile: serviceLocator()));

  // Use cases
  serviceLocator.registerLazySingleton(() => GetUserProfile(serviceLocator()));

  // Repositories
  serviceLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(serviceLocator()));

  // Data sources
  serviceLocator.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl());

  // External dependencies
  serviceLocator.registerLazySingleton(() => Client.new);
}
