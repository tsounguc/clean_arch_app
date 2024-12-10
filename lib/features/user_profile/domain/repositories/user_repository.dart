import 'package:clean_arch_app/core/errors/failures.dart';
import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserById(String id);
}
