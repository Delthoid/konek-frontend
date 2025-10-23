import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';
import 'package:konek_frontend/features/servers/domain/repositories/server_repository.dart';

class GetServersUsecase {
  final ServerRepository _repository;

  GetServersUsecase(this._repository);

  Future<List<ServerEntity>> call() async {
    return _repository.fetchServers();
  }
}
