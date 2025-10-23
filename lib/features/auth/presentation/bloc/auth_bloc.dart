import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:konek_frontend/core/errors/api_exception.dart';
import 'package:konek_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:konek_frontend/features/auth/domain/entities/user_session_entity.dart';
import 'package:konek_frontend/features/auth/domain/usecases/get_stored_session_usecase.dart';
import 'package:konek_frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:konek_frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:konek_frontend/features/auth/domain/usecases/signup_usecase.dart';
import 'package:meta/meta.dart' show immutable;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase = GetIt.I<LoginUsecase>();
  final GetStoredSessionUsecase _getStoredSessionUsecase =
      GetIt.I<GetStoredSessionUsecase>();
  final LogoutUsecase _logoutUsecase = GetIt.I<LogoutUsecase>();
  final SignupUsecase _signupUsecase = GetIt.I<SignupUsecase>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<AuthStarted>((event, emit) async {
      emit(AuthLoading());
      try {
        final userSession = await _getStoredSessionUsecase.call();
        if (userSession != null) {
          emit(AuthLoginSuccess(userSession: userSession));
        } else {
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthInitial());
      }
    });

    on<AuthLoginPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        final userSession = await _loginUsecase.call(
          userName: event.username,
          password: event.password,
        );
        emit(AuthLoginSuccess(userSession: userSession));
      } catch (e) {
        if (e is ApiException) {
          emit(AuthFailure(errorMessage: e.message));
          return;
        }

        emit(AuthFailure(errorMessage: e.toString()));
      }
    });

    on<AuthSignUpPressed>((event, emit) async {
      emit(AuthLoading());

      try {
        final userEntity = await _signupUsecase.call(
          email: event.email,
          userName: event.username,
          password: event.password,
          avatarUrl: '',
        );
        emit(AuthSignupSuccess(userEntity: userEntity));
      } catch (e) {
        if (e is ApiException) {
          emit(AuthFailure(errorMessage: e.message));
          return;
        }

        emit(AuthFailure(errorMessage: e.toString()));
      }
    });

    on<AuthLogoutPressed>((event, emit) async {
      emit(AuthLoading());
      await _logoutUsecase.call();
      emit(AuthInitial());
    });
  }
}
