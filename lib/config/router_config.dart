import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';
import 'package:konek_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konek_frontend/features/auth/presentation/widgets/auth_login_form.dart';
import 'package:konek_frontend/features/auth/presentation/widgets/auth_shell.dart';
import 'package:konek_frontend/features/auth/presentation/widgets/auth_signup_form.dart';
import 'package:konek_frontend/main_app/pages/main_shell.dart';

class AppRouterConfig {
  static GoRouter get router => GoRouter(
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
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        builder: (context, state) => MainShell(child: Container()),
      ),

      ShellRoute(
        redirect: (context, state) {
          final auth = BlocProvider.of<AuthBloc>(context);

          if (auth.state is! AuthLoginSuccess && state.fullPath != RouteNames.signUp) {
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
          )
        ]
      ),
    ],
  );
}
