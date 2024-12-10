import 'package:clean_arch_app/core/errors/failures.dart';
import 'package:clean_arch_app/features/user_profile/data/data_sources/user_remote_data_source.dart';
import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';
import 'package:clean_arch_app/features/user_profile/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.remoteDataSource);
  final UserRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, User>> getUserById(String id) async {
    try {
      final userModel = await remoteDataSource.fetchUserById(id);
      return Right(userModel); // UserModel is compatible with User since it extends it
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
