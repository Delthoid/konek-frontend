part of 'servers_bloc.dart';

sealed class ServersEvent extends Equatable {
  const ServersEvent();

  @override
  List<Object> get props => [];
}

final class ServersStarted extends ServersEvent { }

final class ServerCreated extends ServersEvent {
  final ServerCreateRequest request;

  const ServerCreated(this.request);

  @override
  List<Object> get props => [request];
}

final class ServerUpdated extends ServersEvent {
  final ServerUpdateRequest request;

  const ServerUpdated(this.request);

  @override
  List<Object> get props => [request];
}

final class ServerDeleted extends ServersEvent {
  final String serverId;

  const ServerDeleted(this.serverId);

  @override
  List<Object> get props => [serverId];
}