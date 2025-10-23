import 'package:flutter/material.dart';

class AuthShell extends StatefulWidget {
  const AuthShell({super.key, required this.child});

  final Widget child;

  @override
  State<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends State<AuthShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: widget.child,
    );
  }
}
