import 'dart:convert';

import 'package:konek_frontend/core/services/services.dart';
import 'package:konek_frontend/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:konek_frontend/features/auth/data/models/user_model.dart';
import 'package:konek_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:konek_frontend/features/auth/domain/entities/user_session_entity.dart';
import 'package:konek_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final LocalStorageService _localStorageService;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required LocalStorageService localStorageService,
  }) : _remoteDatasource = remoteDatasource,
       _localStorageService = localStorageService;

  @override
  Future<UserSessionEntity> login({
    required String userName,
    required String password,
  }) async {
    try {
      final userSessionModel = await _remoteDatasource.login(
        userName: userName,
        password: password,
      );
      await _localStorageService.saveKeyValue(
        LocalStorageService.tokenKey,
        userSessionModel.token,
      );
      await _localStorageService.saveKeyValue(
        LocalStorageService.userKey,
        jsonEncode(
          UserModel(
            userId: userSessionModel.user.userId,
            email: userSessionModel.user.email,
            userName: userSessionModel.user.userName,
            createdAt: userSessionModel.user.createdAt,
          ).toJson(),
        ),
      );

      return userSessionModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDatasource.logout();
      await _localStorageService.deleteKey(LocalStorageService.userKey);
      await _localStorageService.deleteKey(LocalStorageService.tokenKey);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUp({
    required String email,
    required String userName,
    required String password,
    String? avatarUrl,
  }) async {
    try {
      final userModel = await _remoteDatasource.signUp(
        email: email,
        userName: userName,
        password: password,
        avatarUrl: avatarUrl,
      );
      // Note: UserModel might not have token, if needed add to model
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserSessionEntity?> getStoredSession() async {
    final token = _localStorageService.getKeyValue(
      LocalStorageService.tokenKey,
    );
    final userJson = _localStorageService.getKeyValue(
      LocalStorageService.userKey,
    );

    if (token != null && userJson != null) {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userMap);
      return UserSessionEntity(token: token, user: userModel, refreshToken: '');
    } else {
      return null;
    }
  }
}
