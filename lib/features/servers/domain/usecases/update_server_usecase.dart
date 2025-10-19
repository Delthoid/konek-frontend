import 'package:konek_frontend/features/servers/domain/models/server_update_request.dart';
import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';
import 'package:konek_frontend/features/servers/domain/repositories/server_repository.dart';

class UpdateServerUsecase {
  final ServerRepository _repository;

  UpdateServerUsecase(this._repository);

  Future<ServerEntity> call(ServerUpdateRequest request) async {
    return await _repository.updateServer(request);
  }
}