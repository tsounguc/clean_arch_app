import 'dart:convert';

import 'package:clean_arch_app/features/user_profile/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
  });

  factory UserModel.fromJson(String source) => UserModel.fromMap(
        jsonDecode(source) as Map<String, dynamic>,
      );

  UserModel.fromMap(Map<String, dynamic> json)
      : this(
          id: int.tryParse(json['id'].toString()) ?? 0,
          name: json['name'] == null ? '' : json['name'] as String,
        );

  UserModel copyWith({
    int? id,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
