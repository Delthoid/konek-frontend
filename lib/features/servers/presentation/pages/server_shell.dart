import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:huge_icons_flutter/huge_icons_flutter.dart';
import 'package:konek_frontend/config/route_names.dart';
import 'package:konek_frontend/config/sizing_config.dart';
import 'package:konek_frontend/core/utils/widget_extensions.dart';

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
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceBright,
              border: Border(right: BorderSide(color: theme.colorScheme.outlineVariant)),
            ),
            constraints: BoxConstraints(maxWidth: 300, minWidth: 250),
            child: Align(
              alignment: Alignment.topCenter,
              // Server and channel sidebar
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                        gradient: LinearGradient(
                          colors: [const Color.fromARGB(255, 243, 249, 255), const Color.fromARGB(255, 218, 238, 255)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.serverId.toString(),
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const Divider(thickness: 0.5,),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Text Channels'),
                        // IconButton.filledTonal(onPressed: () {}, icon: HugeIcon(HugeIcons.add, size: 18)),
                        FilledButton.tonalIcon(onPressed: () {}, label: Text('New'), icon: HugeIcon(HugeIcons.add, size: 18,),)
                      ],
                    ).withPaddingSymmetrical(
                      horizontal: SizingConfig.paddingMedium,
                      vertical: 0,
                    ),

                    ListView.builder(
                      itemBuilder: (context, index) {
                        return Material(
                          type: MaterialType.transparency,
                          child: ListTile(
                            title: Text('Channel $index'),
                            dense: true,
                            leading: Icon(Icons.numbers, size: 18,),
                            minLeadingWidth: 0,
                            onTap: () {
                              context.goNamed(
                                RouteNames.channel,
                                pathParameters: {
                                  'serverId': widget.serverId ?? 'unknown',
                                  'channelId': 'channel_$index',
                                },
                              );
                            },
                          ),
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                    ),
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
