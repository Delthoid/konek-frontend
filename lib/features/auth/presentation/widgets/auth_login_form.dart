import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';
import 'package:konek_frontend/features/auth/presentation/bloc/auth_bloc.dart';

class AuthLoginForm extends StatefulWidget {
  const AuthLoginForm({super.key});

  @override
  State<AuthLoginForm> createState() => _AuthLoginFormState();
}

class _AuthLoginFormState extends State<AuthLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          context.pushReplacementNamed(RouteNames.home);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [

              if (state is AuthFailure) ...[
                Text((state).errorMessage, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
              ],

              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              FilledButton(onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLoginPressed(username: _userNameController.text, password: _passwordController.text));
              }, child: Text('Login'))
            ],
          ),
        );
      },
    );
  }
}
