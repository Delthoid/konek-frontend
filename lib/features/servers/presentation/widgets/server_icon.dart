import 'package:flutter/material.dart';
import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';

class ServerIcon extends StatefulWidget {
  const ServerIcon({super.key, required this.server, this.icon, this.tooltip, required this.onTap});

  final ServerEntity server;
  final Widget? icon;
  final String? tooltip;
  final Function() onTap;

  @override
  State<ServerIcon> createState() => _ServerIconState();
}

class _ServerIconState extends State<ServerIcon> {
  bool _hovering = false;

  String _buildInitial() {
    List<String> splitted = widget.server.name.split(" ");

    if (splitted.length >= 2) {
      return '${splitted.first[0]}${splitted[1][0]}';
    }

    return widget.server.name.isEmpty ? '?' : widget.server.name[0];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: _hovering ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) {
        setState(() {
          _hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Tooltip(
          message: widget.tooltip ?? widget.server.name,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            constraints: BoxConstraints(minWidth: 50, minHeight: 50, maxWidth: 50, maxHeight: 50),
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(_hovering ? 50.0 : 12.0),
              border: _hovering ? Border.all(color: theme.colorScheme.primary, width: 2.0) : null,
            ),
            child: Center(
              child: widget.icon ?? Text(_buildInitial(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }
}
