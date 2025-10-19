
import 'package:konek_frontend/features/servers/data/datasources/servers_remote_data_source.dart';
import 'package:konek_frontend/features/servers/domain/models/server_create_request.dart';
import 'package:konek_frontend/features/servers/domain/models/server_update_request.dart';
import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';
import 'package:konek_frontend/features/servers/domain/repositories/server_repository.dart';

class ServerRepositoryImpl implements ServerRepository {
  final ServersRemoteDataSource _remoteDataSource;

  //TODO: Save the servers in sqlflite

  ServerRepositoryImpl({required ServersRemoteDataSource remoteDatasource}) : _remoteDataSource = remoteDatasource;

  @override
  Future<ServerEntity> createServer(ServerCreateRequest request) async {
    try {
      final serverModel = await _remoteDataSource.createServer(request);
      return serverModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteServer(String serverId) async {
    await _remoteDataSource.deleteServer(serverId);
  }

  @override
  Future<List<ServerEntity>> fetchServers() async {
    try {
      final serverModels = await _remoteDataSource.fetchServers();
      return serverModels;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ServerEntity> updateServer(ServerUpdateRequest request) async {
    try {
      final serverModel = await _remoteDataSource.updateServer(request);
      return serverModel;
    } catch (e) {
      rethrow;
    }
  }
}