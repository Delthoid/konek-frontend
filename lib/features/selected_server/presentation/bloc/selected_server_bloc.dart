import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';

part 'selected_server_event.dart';
part 'selected_server_state.dart';

class SelectedServerBloc extends Bloc<SelectedServerEvent, SelectedServerState> {
  SelectedServerBloc() : super(SelectedServerInitial()) {
    on<SelectedServerSet>((event, emit) {
      
    });
  }
}
