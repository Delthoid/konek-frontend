import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';
import 'package:konek_frontend/core/services/services.dart';
import 'package:konek_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konek_frontend/features/auth/presentation/widgets/auth_login_form.dart';
import 'package:konek_frontend/features/auth/presentation/widgets/auth_shell.dart';
import 'package:konek_frontend/features/auth/presentation/widgets/auth_signup_form.dart';
import 'package:konek_frontend/features/servers/presentation/pages/server_shell.dart';
import 'package:konek_frontend/main_app/pages/main_page.dart';
import 'package:konek_frontend/main_app/pages/main_shell.dart';

class AppRouterConfig {
  final GoRouter _releaseRouter = AppRouterConfig.router;

  /// The route configuration.
  GoRouter get testRouter =>
      kDebugMode ? AppRouterConfig.router : _releaseRouter;

  static GoRouter router = GoRouter(
    initialLocation: RouteNames.home,
    redirect: (context, state) {
      final auth = BlocProvider.of<AuthBloc>(context);

      if (auth.state is AuthLoginSuccess) {
        if (state.fullPath == RouteNames.auth ||
            state.fullPath == RouteNames.login ||
            state.fullPath == RouteNames.signUp) {
          return RouteNames.home;
        }
      } else {
        if (state.fullPath == RouteNames.signUp) {
          return RouteNames.signUp;
        }

        if (state.fullPath != RouteNames.auth &&
            state.fullPath != RouteNames.login &&
            state.fullPath != RouteNames.signUp) {
          return RouteNames.auth;
        }
      }

      return null;
    },
    routes: [
      ShellRoute(
        restorationScopeId: 'test',
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.home,
            name: RouteNames.home,
            builder: (context, state) => const MainPage(),
          ),

          ShellRoute(
            restorationScopeId: 'server_shell',
            builder: (context, state, child) {
              final serverId = state.pathParameters['serverId'] ?? '';
              return ServerShell(serverId: serverId, child: child);
            },
            routes: [
              ShellRoute(
                builder: (context, state, child) => child,
                routes: [
                  GoRoute(
                    path: RouteNames.server,
                    name: RouteNames.server,
                    builder: (context, state) {
                      final serverId = state.pathParameters['serverId'] ?? '';
                      GetIt.I<LoggingService>().logInfo(
                        'Navigating to server with ID: $serverId',
                      );
                      return Text('Server ID: $serverId');
                    },
                  ),
                  GoRoute(
                    path: RouteNames.channel,
                    name: RouteNames.channel,
                    builder: (context, state) {
                      final channelId = state.pathParameters['channelId'] ?? '';
                      GetIt.I<LoggingService>().logInfo(
                        'Navigating to channel with ID: $channelId',
                      );
                      return FilledButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          splashFactory: InkSparkle.splashFactory,
                        ),
                        child: Text('Channel ID: $channelId'),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      ShellRoute(
        redirect: (context, state) {
          final auth = BlocProvider.of<AuthBloc>(context);

          if (auth.state is! AuthLoginSuccess &&
              state.fullPath != RouteNames.signUp) {
            return RouteNames.auth;
          }

          return null;
        },
        builder: (context, state, child) => AuthShell(child: child),
        routes: [
          // Default to login form
          GoRoute(
            name: RouteNames.auth,
            path: RouteNames.auth,
            builder: (context, state) => const AuthLoginForm(),
          ),
          GoRoute(
            name: RouteNames.login,
            path: RouteNames.login,
            builder: (context, state) => const AuthLoginForm(),
          ),
          GoRoute(
            name: RouteNames.signUp,
            path: RouteNames.signUp,
            builder: (context, state) => const AuthSignupForm(),
          ),
        ],
      ),
    ],
  );
}
