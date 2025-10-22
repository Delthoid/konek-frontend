import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';
import 'package:konek_frontend/core/widgets/dialog/custom_alert_dialog.dart';
import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';
import 'package:konek_frontend/features/servers/presentation/bloc/servers_bloc.dart';
import 'package:konek_frontend/features/servers/presentation/widgets/server_create_form.dart';
import 'package:konek_frontend/features/servers/presentation/widgets/server_icon.dart';

class ServerSidebar extends StatefulWidget {
  const ServerSidebar({super.key});

  @override
  State<ServerSidebar> createState() => _ServerSidebarState();
}

class _ServerSidebarState extends State<ServerSidebar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ServersBloc, ServersState>(
      listener: (context, state) {
        if (state is ServersLoadFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text('Error'), content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 65,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Theme(
              data: theme.copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbVisibility: WidgetStatePropertyAll(false),
                  trackVisibility: WidgetStatePropertyAll(false),
                  interactive: false,
                  thickness: WidgetStatePropertyAll(0),
                ),
              ),
              child: ListView(
                children: [
                  ServerIcon(
                    icon: Icon(Icons.home_rounded),
                    server: ServerEntity(
                      id: '',
                      name: '',
                      description: '',
                      ownerId: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    onTap: () {
                      context.goNamed(RouteNames.home);
                    },
                  ),
                  const Divider(),

                  ...List.generate(state.serversList.length, (index) {
                    final server = state.serversList.elementAt(index);
                    return ServerIcon(
                      server: server,
                      onTap: () {
                        context.pushReplacementNamed(RouteNames.server, pathParameters: {'serverId': server.id});
                      },
                    );
                  }),
                  const Divider(),

                  ServerIcon(
                    tooltip: 'Add Server',
                    icon: Icon(Icons.add_rounded),
                    server: ServerEntity(
                      id: '',
                      name: '',
                      description: '',
                      ownerId: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          title: 'Add Server',
                          width: 400,
                          showCloseButton: true,
                          content: ServerCreateForm(),
                        ),
                        barrierDismissible: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
