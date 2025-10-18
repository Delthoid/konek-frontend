import 'package:konek_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:konek_frontend/features/auth/domain/entities/user_session_entity.dart';

abstract class AuthRepository {
  Future<UserSessionEntity> login({required String userName, required String password});
  Future<UserEntity> signUp({required String email, required String userName, required String password, String? avatarUrl});
  Future<void> logout();
}