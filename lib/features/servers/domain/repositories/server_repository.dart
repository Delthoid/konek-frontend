import 'package:konek_frontend/features/servers/domain/models/server_create_request.dart';
import 'package:konek_frontend/features/servers/domain/models/server_update_request.dart';
import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';

abstract class ServerRepository {
  Future<List<ServerEntity>> fetchServers();
  Future<ServerEntity> createServer(ServerCreateRequest request);
  Future<ServerEntity> updateServer(ServerUpdateRequest request);
  Future<void> deleteServer(String serverId);
}
