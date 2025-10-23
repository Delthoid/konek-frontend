import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:konek_frontend/config/api_config.dart';
import 'package:konek_frontend/core/errors/api_exception.dart';
import 'package:konek_frontend/core/models/api_response.dart';
import 'package:konek_frontend/core/services/services.dart';

class ApiService {
  final Dio _dio;
  final String _baseUrl = ApiConfig.baseUrl;
  final LoggingService _logger = GetIt.I<LoggingService>();
  final LocalStorageService _localStorageService =
      GetIt.I<LocalStorageService>();

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          receiveDataWhenStatusError: true,
          validateStatus: (status) => status! < 500,
          headers: {'Content-type': 'application/json'},
        ),
      );

  Uri makeUri(String path) {
    return Uri.parse('$_baseUrl$path');
  }

  Map<String, String> _makeHeaders() {
    String token =
        _localStorageService.getKeyValue(LocalStorageService.tokenKey) ?? '';
    return {'Authorization': 'Bearer $token'};
  }

  Future<Response<ApiResponse<T>>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio
        .get(
          path,
          queryParameters: queryParameters,
          options: Options(headers: _makeHeaders()),
        )
        .then((response) {
          _logger.logInfo(
            'GET ${makeUri(path)} - Status: ${response.statusCode}',
          );

          return Response<ApiResponse<T>>(
            data: ApiResponse.fromJson(response.data, (json) => json as T),
            statusCode: response.statusCode,
            headers: response.headers,
            requestOptions: RequestOptions(),
          );
        })
        .catchError((error) {
          _logger.logError('GET ${makeUri(path)} - Error: $error');
          throw error;
        });
  }

  Future<Response<ApiResponse<T>>> post<T>(String path, {dynamic data}) {
    return _dio
        .post(
          path,
          data: data,
          options: Options(headers: _makeHeaders()),
        )
        .then((response) {
          _logger.logInfo(
            'POST ${makeUri(path)} - Status: ${response.statusCode}',
          );

          if ((response.statusCode ?? 500) >= 400) {
            final error = response.data['error'] ?? 'Not Found';
            final errorMessage =
                response.data['message'] ??
                'The requested resource was not found.';
            throw ApiException('$error: $errorMessage');
          }

          return Response<ApiResponse<T>>(
            data: ApiResponse.fromJson(response.data, (json) => json as T),
            statusCode: response.statusCode,
            headers: response.headers,
            requestOptions: RequestOptions(receiveDataWhenStatusError: true),
          );
        })
        .catchError((error) {
          _logger.logError('POST ${makeUri(path)} - Error: $error');
          throw error;
        });
  }

  Future<Response<ApiResponse<T>>> put<T>(String path, {dynamic data}) {
    return _dio
        .put(
          path,
          data: data,
          options: Options(headers: _makeHeaders()),
        )
        .then((response) {
          _logger.logInfo(
            'PUT ${makeUri(path)} - Status: ${response.statusCode}',
          );

          return Response<ApiResponse<T>>(
            data: ApiResponse.fromJson(response.data, (json) => json as T),
            statusCode: response.statusCode,
            headers: response.headers,
            requestOptions: RequestOptions(),
          );
        })
        .catchError((error) {
          _logger.logError('PUT ${makeUri(path)} - Error: $error');
          throw error;
        });
  }

  Future<Response<ApiResponse<T>>> delete<T>(String path, {dynamic data}) {
    return _dio
        .delete(
          path,
          data: data,
          options: Options(headers: _makeHeaders()),
        )
        .then((response) {
          _logger.logInfo(
            'DELETE ${makeUri(path)} - Status: ${response.statusCode}',
          );

          return Response<ApiResponse<T>>(
            data: ApiResponse.fromJson(response.data, (json) => json as T),
            statusCode: response.statusCode,
            headers: response.headers,
            requestOptions: RequestOptions(),
          );
        })
        .catchError((error) {
          _logger.logError('DELETE ${makeUri(path)} - Error: $error');
          throw error;
        });
  }
}
