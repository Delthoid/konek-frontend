import 'package:get_it/get_it.dart';
import 'package:konek_frontend/core/services/services.dart' show LoggingService, ApiService;

final di = GetIt.instance;

Future<void> setupDI() async {
  di.registerLazySingleton<LoggingService>(() => LoggingService());
  di.registerLazySingleton<ApiService>(() => ApiService());
}