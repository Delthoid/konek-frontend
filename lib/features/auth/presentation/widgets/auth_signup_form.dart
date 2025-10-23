import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konek_frontend/config/route_names.dart';
import 'package:konek_frontend/features/auth/presentation/bloc/auth_bloc.dart';

class AuthSignupForm extends StatefulWidget {
  const AuthSignupForm({super.key});

  @override
  State<AuthSignupForm> createState() => _AuthSignupFormState();
}

class _AuthSignupFormState extends State<AuthSignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignupSuccess) {
          context.pushReplacementNamed(RouteNames.login);
        }
      },
      builder: (context, state) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (state is AuthFailure) ...[
                  Text(
                    (state).errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                ],

                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthSignUpPressed(
                          email: _emailController.text,
                          username: _userNameController.text,
                          password: _passwordController.text,
                        ),
                      );
                    }
                  },
                  child: Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(RouteNames.login);
                  },
                  child: Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
