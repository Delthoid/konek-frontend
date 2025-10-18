import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';
import 'package:konek_frontend/features/auth/presentation/bloc/auth_bloc.dart';
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          context.pushReplacementNamed(RouteNames.auth);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(child: widget.child),
              const UserProfileFooter(),
            ],
          ),
        );
      },
    );
  }
}
