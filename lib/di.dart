import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:konek_frontend/core/services/services.dart'
    show LoggingService, ApiService, SecureStorageService, LocalStorageService;
import 'package:konek_frontend/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:konek_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:konek_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:konek_frontend/features/auth/domain/usecases/get_stored_session_usecase.dart';
import 'package:konek_frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:konek_frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:konek_frontend/features/auth/domain/usecases/signup_usecase.dart';
import 'package:konek_frontend/features/servers/data/datasources/servers_remote_data_source.dart';
import 'package:konek_frontend/features/servers/data/repositories/server_repository_impl.dart';
import 'package:konek_frontend/features/servers/domain/repositories/server_repository.dart';
import 'package:konek_frontend/features/servers/domain/usecases/create_server_usecase.dart';
import 'package:konek_frontend/features/servers/domain/usecases/delete_server_usecase.dart';
import 'package:konek_frontend/features/servers/domain/usecases/get_servers_usecase.dart';
import 'package:konek_frontend/features/servers/domain/usecases/update_server_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> setupDI() async {
  // Initialize SharedPreferences first
  final prefs = await SharedPreferences.getInstance();

  di.registerLazySingleton<LoggingService>(() => LoggingService());
  di.registerLazySingleton<ApiService>(() => ApiService());
  di.registerLazySingleton<SecureStorageService>(() => SecureStorageService(const FlutterSecureStorage()));

  // Now register LocalStorageService as regular singleton (not async)
  di.registerLazySingleton<LocalStorageService>(() => LocalStorageService(prefs));

  di.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(apiService: di<ApiService>(), loggingService: di<LoggingService>()),
  );

  di.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: di<AuthRemoteDatasource>(),
      localStorageService: di<LocalStorageService>(),
    ),
  );

  di.registerFactory<LoginUsecase>(() => LoginUsecase(authRepository: di<AuthRepository>()));
  di.registerFactory<GetStoredSessionUsecase>(() => GetStoredSessionUsecase(di<AuthRepository>()));
  di.registerFactory<LogoutUsecase>(() => LogoutUsecase(di<AuthRepository>()));
  di.registerFactory<SignupUsecase>(() => SignupUsecase(di<AuthRepository>()));

  // Servers
  di.registerFactory<ServersRemoteDataSource>(
    () => ServersRemoteDataSourceImpl(apiService: di<ApiService>(), loggingService: di<LoggingService>()),
  );
  di.registerFactory<ServerRepository>(
    () => ServerRepositoryImpl(
      remoteDatasource: di<ServersRemoteDataSource>(),
    )
  );

  di.registerFactory<CreateServerUsecase>(() => CreateServerUsecase(di<ServerRepository>()));
  di.registerFactory<DeleteServerUsecase>(() => DeleteServerUsecase(di<ServerRepository>()));
  di.registerFactory<UpdateServerUsecase>(() => UpdateServerUsecase(di<ServerRepository>()));
  di.registerFactory<GetServersUsecase>(() => GetServersUsecase(di<ServerRepository>()));
}
