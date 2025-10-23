import 'package:konek_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:konek_frontend/features/auth/domain/repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository _authRepository;

  SignupUsecase(this._authRepository);

  Future<UserEntity> call({
    required String email,
    required String userName,
    required String password,
    String? avatarUrl,
  }) async {
    return await _authRepository.signUp(
      email: email,
      userName: userName,
      password: password,
      avatarUrl: avatarUrl,
    );
  }
}
