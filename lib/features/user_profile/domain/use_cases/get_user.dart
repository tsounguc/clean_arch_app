import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';
import 'package:clean_arch_app/features/user_profile/domain/repository/user_repository.dart';

class GetUserProfile {
  GetUserProfile(this.repository);

  final UserRepository repository;

  Future<User> call(String userId) async {
    return await repository.getUserById(userId);
  }
}
