import 'package:clean_arch_app/features/user_profile/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> fetchUserById(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel> fetchUserById(String id) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users/$id');
    try {
      final response = await http.get(url);
      final user = UserModel.fromJson(response.body);
      return user;
    } catch (e, s) {
      debugPrintStack(stackTrace: s, label: 'Failed to fetch user: $e');
      throw Exception('Network error: $e');
    }
  }
}
