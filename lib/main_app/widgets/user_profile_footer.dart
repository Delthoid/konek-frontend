import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konek_frontend/features/auth/presentation/bloc/auth_bloc.dart';

class UserProfileFooter extends StatefulWidget {
  const UserProfileFooter({super.key});

  @override
  State<UserProfileFooter> createState() => _UserProfileFooterState();
}

class _UserProfileFooterState extends State<UserProfileFooter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return FilledButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(AuthLogoutPressed());
          },
          child: Text('Logout'),
        );
      },
    );
  }
}
