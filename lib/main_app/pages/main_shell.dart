import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';
import 'package:konek_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konek_frontend/features/servers/presentation/bloc/servers_bloc.dart';
import 'package:konek_frontend/features/servers/presentation/widgets/server_sidebar.dart';
import 'package:konek_frontend/main_app/widgets/user_profile_footer.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              context.pushReplacementNamed(RouteNames.auth);
            }
          },
        ),
        BlocListener<ServersBloc, ServersState>(
          listener: (context, state) {
            // Occured after logging in, calling the LoadServers without authentication leads to ServersLoaderFailure
            BlocProvider.of<ServersBloc>(context).add(ServersStarted());
          },
          // Lookout for potential issues for infinite call
          listenWhen: (prev, curr) => prev is ServersInitial && true,
        ),
      ],
      child: Scaffold(
        body: Row(
          children: [
            const SizedBox(width: 8),
            ServerSidebar(),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: widget.child,
              ),
            ),
            const UserProfileFooter(),
          ],
        ),
      ),
    );
  }
}
