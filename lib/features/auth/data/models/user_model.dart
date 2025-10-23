import 'package:konek_frontend/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.email,
    required super.userName,
    required super.createdAt,
    super.avatarUrl,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      userName: json['userName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      avatarUrl: json['avatarUrl'] as String?,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'userName': userName,
      'createdAt': createdAt.toIso8601String(),
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }
}
