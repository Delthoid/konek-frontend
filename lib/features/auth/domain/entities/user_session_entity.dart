import 'package:konek_frontend/features/auth/domain/entities/user_entity.dart';

class UserSessionEntity {
  final UserEntity user;
  final String token;
  final String refreshToken;

  UserSessionEntity({
    required this.user,
    required this.token,
    required this.refreshToken,
  });
}
