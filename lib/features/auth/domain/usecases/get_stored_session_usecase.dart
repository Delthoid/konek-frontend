import 'package:konek_frontend/features/auth/domain/entities/user_session_entity.dart';
import 'package:konek_frontend/features/auth/domain/repositories/auth_repository.dart';

class GetStoredSessionUsecase {
  final AuthRepository _authRepository;

  GetStoredSessionUsecase(this._authRepository);

  Future<UserSessionEntity?> call() {
    return _authRepository.getStoredSession();
  }
}
