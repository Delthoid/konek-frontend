part of 'selected_server_bloc.dart';

sealed class SelectedServerEvent extends Equatable {
  
  const SelectedServerEvent();

  @override
  List<Object?> get props => [];
}

class SelectedServerStarted extends SelectedServerEvent { }

class SelectedServerSet extends SelectedServerEvent {
  final ServerEntity selectedServer;

  const SelectedServerSet({required this.selectedServer});
}