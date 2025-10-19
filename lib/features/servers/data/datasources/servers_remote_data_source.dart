import 'package:konek_frontend/config/api_endpoints.dart';
import 'package:konek_frontend/core/errors/api_exception.dart';
import 'package:konek_frontend/core/services/services.dart';
import 'package:konek_frontend/features/servers/domain/models/server_create_request.dart';
import 'package:konek_frontend/features/servers/data/models/server_model.dart';
import 'package:konek_frontend/features/servers/domain/models/server_update_request.dart';

abstract class ServersRemoteDataSource {
  Future<List<ServerModel>> fetchServers();
  Future<ServerModel> createServer(ServerCreateRequest request);
  Future<ServerModel> updateServer(ServerUpdateRequest request);
  Future<void> deleteServer(String serverId);
}

class ServersRemoteDataSourceImpl implements ServersRemoteDataSource {

  final ApiService _apiService;
  final LoggingService _loggingService;

  ServersRemoteDataSourceImpl({
    required ApiService apiService,
    required LoggingService loggingService,
  })  : _apiService = apiService,
        _loggingService = loggingService;

  @override
  Future<ServerModel> createServer(ServerCreateRequest request) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.createServer,
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return ServerModel.fromJson(response.data?.data);
      } else {
        throw Exception('Failed to create server with status code: ${response.statusCode}');
      }
    } catch (e) {
      _loggingService.logError('Error creating server: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteServer(String serverId) async {
    try {
      final response = await _apiService.delete(
        '${ApiEndpoints.deleteServer}/$serverId',
      );

      if (response.statusCode != 204) {
        throw ApiException('Failed to delete server with status code: ${response.statusCode}');
      }
    } catch (e) {
      _loggingService.logError('Error deleting server: $e');
      rethrow;
    }
  }

  @override
  Future<List<ServerModel>> fetchServers() async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.getServers
      );

      if (response.statusCode == 200) {
        return (response.data?.data as List<dynamic>).map((serverJson) {
          return ServerModel.fromJson(serverJson);
        }).toList();
      } else {
        throw ApiException('There was a problem fetching servers with status code: ${response.statusCode}');
      }
    } catch (e) {
      _loggingService.logError('Error on fetching servers: $e');
      rethrow;
    }
  }

  @override
  Future<ServerModel> updateServer(ServerUpdateRequest request) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.updateServer,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return ServerModel.fromJson(response.data?.data);
      } else {
        throw ApiException('There was a problem udpating server with status code: ${response.statusCode}');
      }
    } catch (e) {
      _loggingService.logError('Error on updating server: $e');
      rethrow;
    }
  }

}