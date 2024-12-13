import 'package:clean_arch_app/core/errors/failures.dart';
import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';
import 'package:clean_arch_app/features/user_profile/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserProfile {
  GetUserProfile(this.repository);

  final UserRepository repository;

  Future<Either<Failure, User>> call(String userId) async {
    return await repository.getUserById(userId);
  }
}
