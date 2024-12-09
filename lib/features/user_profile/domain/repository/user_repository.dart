import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserById(String id);
}