import 'package:konek_frontend/features/auth/data/models/user_model.dart';
import 'package:konek_frontend/features/auth/domain/entities/user_session_entity.dart';

class UserSessionModel extends UserSessionEntity {
  UserSessionModel({required super.user, required super.token, required super.refreshToken});

  factory UserSessionModel.fromJson(Map<String, dynamic> json) {
    return UserSessionModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }
}
