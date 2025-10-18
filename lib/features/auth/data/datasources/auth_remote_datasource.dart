import 'package:konek_frontend/config/api_endpoints.dart';
import 'package:konek_frontend/core/errors/errors.dart' show ApiException;
import 'package:konek_frontend/core/services/services.dart';
import 'package:konek_frontend/features/auth/data/models/user_model.dart';
import 'package:konek_frontend/features/auth/data/models/user_session_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserSessionModel> login({required String userName, required String password});
  Future<UserModel> signUp({required String email, required String userName, required String password, String? avatarUrl});
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {

  final ApiService _apiService;
  final LoggingService _loggingService;

  AuthRemoteDatasourceImpl({
    required ApiService apiService,
    required LoggingService loggingService,
  }) : _apiService = apiService,
       _loggingService = loggingService;

  @override
  Future<UserSessionModel> login({required String userName, required String password}) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.login,
        data: {
          'userName': userName,
          'password': password,
        }
      );

      if (response.statusCode == 200) {
        return UserSessionModel.fromJson(response.data?.data);
      } else {
        throw ApiException('Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      _loggingService.logError('AuthRemoteDatasource - login: $e');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    _loggingService.logInfo('AuthRemoteDatasource - logout called');
  }

  @override
  Future<UserModel> signUp({required String email, required String userName, required String password, String? avatarUrl}) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.signUp,
        data: {
          'email': email,
          'userName': userName,
          'password': password,
          'avatarUrl': avatarUrl ?? '',
        }
      );

      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data?.data);
      } else {
        throw ApiException('Sign up failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      _loggingService.logError('AuthRemoteDatasource - signUp: $e');
      rethrow;
    }
  }

}