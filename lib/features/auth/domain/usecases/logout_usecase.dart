import 'package:konek_frontend/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository _repository;

  LogoutUsecase(this._repository);

  Future<void> call() async {
    await _repository.logout();
  }
}
