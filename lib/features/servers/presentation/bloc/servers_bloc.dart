import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:konek_frontend/core/errors/api_exception.dart';
import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';
import 'package:konek_frontend/features/servers/domain/models/server_create_request.dart';
import 'package:konek_frontend/features/servers/domain/models/server_update_request.dart';
import 'package:konek_frontend/features/servers/domain/usecases/create_server_usecase.dart';
import 'package:konek_frontend/features/servers/domain/usecases/delete_server_usecase.dart';
import 'package:konek_frontend/features/servers/domain/usecases/get_servers_usecase.dart';
import 'package:konek_frontend/features/servers/domain/usecases/update_server_usecase.dart';

part 'servers_event.dart';
part 'servers_state.dart';

class ServersBloc extends Bloc<ServersEvent, ServersState> {
  final CreateServerUsecase _createServerUsecase =
      GetIt.I<CreateServerUsecase>();
  final DeleteServerUsecase _deleteServerUsecase =
      GetIt.I<DeleteServerUsecase>();
  final GetServersUsecase _getServersUsecase = GetIt.I<GetServersUsecase>();
  final UpdateServerUsecase _updateServerUsecase =
      GetIt.I<UpdateServerUsecase>();

  ServersBloc() : super(ServersInitial()) {
    on<ServersStarted>((event, emit) async {
      emit(ServersLoadInProgress());
      try {
        final servers = await _getServersUsecase.call();
        emit(ServersLoadSuccess(servers));
      } catch (e) {
        if (e is ApiException) {
          emit(
            ServersLoadFailure(
              'There was problem loading servers. ${e.message}',
              servers: state.serversList,
            ),
          );
          return;
        }

        emit(
          ServersLoadFailure(
            'There was a problem loading servers',
            servers: state.serversList,
          ),
        );
      }
    }, transformer: droppable());

    on<ServerCreated>((event, emit) async {
      emit(ServerCreateInProgress(servers: state.serversList));
      try {
        final server = await _createServerUsecase.call(event.request);
        final newServers = [server, ...state.serversList];

        emit(ServersLoadSuccess(newServers));
      } catch (e) {
        if (e is ApiException) {
          emit(ServersLoadFailure(e.message, servers: state.serversList));
          return;
        }

        emit(
          ServersLoadFailure(
            'There was problem on creating server',
            servers: state.serversList,
          ),
        );
      }
    }, transformer: droppable());

    on<ServerUpdated>((event, emit) async {
      emit(ServerUpdateInProgress(servers: state.serversList));
      try {
        final updatedServer = await _updateServerUsecase.call(event.request);
        final updatedServers = [
          ...state.serversList.map((server) {
            if (event.request.id == server.id) {
              return updatedServer;
            }
            return server;
          }),
        ];

        emit(ServersLoadSuccess(updatedServers));
      } catch (e) {
        if (e is ApiException) {
          emit(
            ServersLoadFailure(
              'There was problem on updating server. ${e.message}',
              servers: state.serversList,
            ),
          );
          return;
        }

        emit(
          ServersLoadFailure(
            'There was problem on updating server',
            servers: state.serversList,
          ),
        );
      }
    }, transformer: droppable());

    on<ServerDeleted>((event, emit) async {
      emit(ServerDeleteInProgress(servers: state.serversList));
      try {
        await _deleteServerUsecase.call(event.serverId);
        final updatedServers = [
          ...state.serversList.where((server) => server.id != event.serverId),
        ];

        emit(ServersLoadSuccess(updatedServers));
      } catch (e) {
        if (e is ApiException) {
          emit(
            ServersLoadFailure(
              'There was problem on deleting server. ${e.message}',
              servers: state.serversList,
            ),
          );
          return;
        }

        emit(
          ServersLoadFailure(
            'There was problem on deleting server',
            servers: state.serversList,
          ),
        );
      }
    }, transformer: droppable());
  }
}
