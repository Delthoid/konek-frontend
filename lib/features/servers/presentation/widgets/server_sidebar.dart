import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';
import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';
import 'package:konek_frontend/features/servers/presentation/widgets/server_icon.dart';

class ServerSidebar extends StatefulWidget {
  const ServerSidebar({super.key});

  @override
  State<ServerSidebar> createState() => _ServerSidebarState();
}

class _ServerSidebarState extends State<ServerSidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ServerIcon(
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
            ...List.generate(10, (index) {
              return ServerIcon(
                icon: Icon(Icons.gamepad),
                server: ServerEntity(
                  id: '',
                  name: 'Server $index',
                  description: '',
                  ownerId: '',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
                onTap: () {
                  context.pushReplacementNamed(RouteNames.server, pathParameters: {'serverId': 'server_$index'});
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}