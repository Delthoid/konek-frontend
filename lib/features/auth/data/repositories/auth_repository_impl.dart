import 'dart:convert';

import 'package:konek_frontend/core/errors/errors.dart';
import 'package:konek_frontend/core/services/services.dart';
import 'package:konek_frontend/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:konek_frontend/features/auth/data/models/user_model.dart';
import 'package:konek_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:konek_frontend/features/auth/domain/entities/user_session_entity.dart';
import 'package:konek_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final SecureStorageService _secureStorageService;
  final LocalStorageService _localStorageService;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required SecureStorageService secureStorageService,
    required LocalStorageService localStorageService,
  })  : _remoteDatasource = remoteDatasource,
        _secureStorageService = secureStorageService,
        _localStorageService = localStorageService;

  @override
  Future<UserSessionEntity> login({required String userName, required String password}) async {
    try {
      final userSessionModel = await _remoteDatasource.login(userName: userName, password: password);
      await _secureStorageService.saveToken(userSessionModel.token);

      // Save the user object to local storage
      await _localStorageService.saveKeyValue(
        LocalStorageService.userKey,
        jsonEncode(
          UserModel(
            id: userSessionModel.user.id,
            email: userSessionModel.user.email,
            name: userSessionModel.user.name,
            createdAt: userSessionModel.user.createdAt,
          ).toJson(),
        ),
      );

      return userSessionModel;
    } catch (e) {
      throw ApiException('AuthRepository - login: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDatasource.logout();
      await _secureStorageService.deleteToken();
      await _localStorageService.deleteKey(LocalStorageService.userKey);
    } catch (e) {
      throw ApiException('AuthRepository - logout: $e');
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
      throw ApiException('AuthRepository - signUp: $e');
    }
  }
}
