part of 'servers_bloc.dart';

sealed class ServersState extends Equatable {
  final List<ServerEntity> serversList;

  const ServersState({this.serversList = const []});

  @override
  List<Object> get props => [serversList];
}

final class ServersInitial extends ServersState {
  const ServersInitial();
}

final class ServersLoadInProgress extends ServersState {
  const ServersLoadInProgress();
}

final class ServersLoadSuccess extends ServersState {
  final List<ServerEntity> servers;

  const ServersLoadSuccess(this.servers) : super(serversList: servers);

  @override
  List<Object> get props => [servers];
}

final class ServersLoadFailure extends ServersState {
  final String message;

  const ServersLoadFailure(
    this.message, {
    List<ServerEntity> servers = const [],
  }) : super(serversList: servers);
}

// Create server

final class ServerCreateInProgress extends ServersState {
  const ServerCreateInProgress({List<ServerEntity> servers = const []})
    : super(serversList: servers);
}

final class ServerCreateFailure extends ServersState {
  final String message;

  const ServerCreateFailure(
    this.message, {
    List<ServerEntity> servers = const [],
  }) : super(serversList: servers);
}

// Update server

final class ServerUpdateInProgress extends ServersState {
  const ServerUpdateInProgress({List<ServerEntity> servers = const []})
    : super(serversList: servers);
}

final class ServerUpdateFailure extends ServersState {
  final String message;

  const ServerUpdateFailure(
    this.message, {
    List<ServerEntity> servers = const [],
  }) : super(serversList: servers);
}

// Delete server

final class ServerDeleteInProgress extends ServersState {
  const ServerDeleteInProgress({List<ServerEntity> servers = const []})
    : super(serversList: servers);
}

final class ServerDeleteFailure extends ServersState {
  final String message;

  const ServerDeleteFailure(
    this.message, {
    List<ServerEntity> servers = const [],
  }) : super(serversList: servers);
}
