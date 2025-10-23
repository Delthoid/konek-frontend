import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:konek_frontend/core/services/services.dart';

import 'services.dart' show LoggingService;

class BlocObserverService extends BlocObserver {
  final LoggingService _loggingService = GetIt.I<LoggingService>();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _loggingService.logInfo('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _loggingService.logInfo('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _loggingService.logError('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _loggingService.logInfo('onClose -- ${bloc.runtimeType}');
  }
}
