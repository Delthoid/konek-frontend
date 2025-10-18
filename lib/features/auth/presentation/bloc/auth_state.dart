part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoadSuccess extends AuthState {
  final UserSessionEntity userSessionEntity;

  AuthLoadSuccess({required this.userSessionEntity});
}

final class AuthLoginSuccess extends AuthLoadSuccess {
  final UserSessionEntity userSession;

  AuthLoginSuccess({required this.userSession}) : super(userSessionEntity: userSession);
}

final class AuthSignupSuccess extends AuthState {
  final UserEntity userEntity;

  AuthSignupSuccess({required this.userEntity});
}

final class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}
