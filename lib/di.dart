import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:konek_frontend/core/services/services.dart' show LoggingService, ApiService, SecureStorageService, LocalStorageService;
import 'package:konek_frontend/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:konek_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:konek_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:konek_frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> setupDI() async {

  di.registerLazySingleton<LoggingService>(() => LoggingService());
  di.registerLazySingleton<ApiService>(() => ApiService());
  di.registerLazySingleton<SecureStorageService>(() => SecureStorageService(FlutterSecureStorage(
    
  )));
  di.registerLazySingletonAsync<LocalStorageService>(() async => LocalStorageService(await SharedPreferences.getInstance()));
  
  di.registerFactory<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(
    apiService: di<ApiService>(),
    loggingService: di<LoggingService>(),
  ));

  di.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
    remoteDatasource: di<AuthRemoteDatasource>(),
    secureStorageService: di<SecureStorageService>(),
    localStorageService: di<LocalStorageService>(),
  ));

  di.registerFactory<LoginUsecase>(() => LoginUsecase(
    authRepository: di<AuthRepository>(),
  ));
}