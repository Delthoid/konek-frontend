import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';

class ServerShell extends StatefulWidget {
  const ServerShell({super.key, this.serverId, this.child});

  final String? serverId;
  final Widget? child; // Supplied when passing channel id

  @override
  State<ServerShell> createState() => _ServerShellState();
}

class _ServerShellState extends State<ServerShell> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: Row(
        children: [
          // Server info and channel sidebar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
            ),
            constraints: BoxConstraints(
              maxWidth: 300,
              minWidth: 250,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [
                            Colors.pink[100]!,
                            Colors.blue[100]!,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text('Server: ${widget.serverId ?? 'Unknown'}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: ListView.builder(itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Channel $index'),
                          onTap: () {
                            context.goNamed(
                              RouteNames.channel,
                              pathParameters: {
                                'serverId': widget.serverId ?? 'unknown',
                                'channelId': 'channel_$index',
                              },
                            );
                          },
                        );
                      }, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: 10
                    ),
                    ),
                
                    FilledButton(onPressed: () {
                      context.goNamed(
                        RouteNames.channel,
                        pathParameters: {
                          'serverId': widget.serverId ?? 'unknown',
                          'channelId': 'test_channel',
                        },
                      );
                    }, child: Text('Test Channel')),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: widget.child ?? Center(child: Text('No Channel Selected'))),
        ],
      ),
    );
  }
}
