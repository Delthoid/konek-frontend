import 'package:konek_frontend/features/servers/domain/repositories/server_repository.dart';

class DeleteServerUsecase {
  final ServerRepository _repository;

  DeleteServerUsecase(this._repository);

  Future<void> call(String serverId) async {
    return await _repository.deleteServer(serverId);
  }
}