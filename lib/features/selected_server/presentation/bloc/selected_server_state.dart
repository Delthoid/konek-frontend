part of 'selected_server_bloc.dart';

sealed class SelectedServerState extends Equatable {
  const SelectedServerState();
  @override
  List<Object> get props => [];
}

class SelectedServerInitial extends SelectedServerState {
  const SelectedServerInitial();
}

class SelectedServerLoading extends SelectedServerState {}

class SelectedServerLoaded extends SelectedServerState {
  final ServerEntity server;
  const SelectedServerLoaded({required this.server});

  @override
  List<Object> get props => [server];
}

class SelectedServerError extends SelectedServerState {
  final String message;

  const SelectedServerError({required this.message});

  @override
  List<Object> get props => [message];
}
