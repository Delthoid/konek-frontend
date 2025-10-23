import 'package:konek_frontend/features/auth/domain/entities/user_session_entity.dart';
import 'package:konek_frontend/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _authRepository;

  LoginUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Future<UserSessionEntity> call({
    required String userName,
    required String password,
  }) async {
    return await _authRepository.login(userName: userName, password: password);
  }
}
