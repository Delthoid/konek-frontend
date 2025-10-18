import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';

class AppRouterConfig {
  static GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: [GoRoute(path: RouteNames.home, name: RouteNames.home, builder: (context, state) => const Placeholder(
      color: Colors.red,
    ))],
  );
}
