part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthStarted extends AuthEvent {}

final class AuthLoginPressed extends AuthEvent {
  final String username;
  final String password;

  AuthLoginPressed({required this.username, required this.password});
}

final class AuthSignUpPressed extends AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthSignUpPressed({
    required this.username,
    required this.email,
    required this.password,
  });
}

final class AuthLogoutPressed extends AuthEvent {}
