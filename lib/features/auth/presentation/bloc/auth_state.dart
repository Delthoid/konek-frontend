part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadInProgress extends AuthState {}

final class AuthLoadSuccess extends AuthState {
  final String userId;

  AuthLoadSuccess({required this.userId});
}