import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:konek_frontend/core/models/api_response.dart';
import 'package:konek_frontend/core/services/env_service.dart';
import 'package:konek_frontend/core/services/logging_service.dart';

class ApiService {
  final Dio _dio;
  final String _baseUrl = EnvService.baseUrl;
  final LoggingService _logger = GetIt.I<LoggingService>();

  ApiService() : _dio = Dio(BaseOptions(baseUrl: EnvService.baseUrl));

  Uri makeUri(String path) {
    return Uri.parse('$_baseUrl$path');
  }

  Future<Response<ApiResponse<T>>> get<T>(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters).then((response) {
      _logger.logInfo(
        'GET ${makeUri(path)} - Status: ${response.statusCode}',
      );

      return Response<ApiResponse<T>>(
        data: ApiResponse.fromJson(response.data, (json) => json as T),
        statusCode: response.statusCode,
        headers: response.headers,
        requestOptions: RequestOptions(),
      );
    }).catchError((error) {
      _logger.logError('GET ${makeUri(path)} - Error: $error');
      throw error;
    });
  }

  Future<Response<ApiResponse<T>>> post<T>(String path, {dynamic data}) {
    return _dio.post(path, data: data).then((response) {

      _logger.logInfo(
        'POST ${makeUri(path)} - Status: ${response.statusCode}',
      );

      return Response<ApiResponse<T>>(
        data: ApiResponse.fromJson(response.data, (json) => json as T),
        statusCode: response.statusCode,
        headers: response.headers,
        requestOptions: RequestOptions(),
      );
    }).catchError((error) {
      _logger.logError('POST ${makeUri(path)} - Error: $error');
      throw error;
    });
  }

  Future<Response<ApiResponse<T>>> put<T>(String path, {dynamic data}) {
    return _dio.put(path, data: data).then((response) {

      _logger.logInfo(
        'PUT ${makeUri(path)} - Status: ${response.statusCode}',
      );

      return Response<ApiResponse<T>>(
        data: ApiResponse.fromJson(response.data, (json) => json as T),
        statusCode: response.statusCode,
        headers: response.headers,
        requestOptions: RequestOptions(),
      );
    }).catchError((error) {
      _logger.logError('PUT ${makeUri(path)} - Error: $error');
      throw error;
    });
  }

  Future<Response<ApiResponse<T>>> delete<T>(String path, {dynamic data}) {
    return _dio.delete(path, data: data).then((response) {

      _logger.logInfo(
        'DELETE ${makeUri(path)} - Status: ${response.statusCode}',
      );

      return Response<ApiResponse<T>>(
        data: ApiResponse.fromJson(response.data, (json) => json as T),
        statusCode: response.statusCode,
        headers: response.headers,
        requestOptions: RequestOptions(),
      );
    }).catchError((error) {
      _logger.logError('DELETE ${makeUri(path)} - Error: $error');
      throw error;
    });
  }
}
