import 'package:konek_frontend/features/servers/domain/models/server_create_request.dart';
import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';
import 'package:konek_frontend/features/servers/domain/repositories/server_repository.dart';

class CreateServerUsecase {
  final ServerRepository _repository;

  CreateServerUsecase(this._repository);

  Future<ServerEntity> call(ServerCreateRequest request) async {
    return await _repository.createServer(request);
  }
}
