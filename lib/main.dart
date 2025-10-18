import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konek_frontend/config/router_config.dart';
import 'package:konek_frontend/core/services/bloc_observer_service.dart';
import 'package:konek_frontend/di.dart';
import 'package:konek_frontend/features/auth/presentation/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  Bloc.observer = BlocObserverService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()..add(AuthStarted())),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        routerConfig: AppRouterConfig.router,
      ),
    );
  }
}