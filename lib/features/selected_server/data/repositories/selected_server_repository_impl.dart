import 'package:konek_frontend/features/selected_server/data/datasources/selected_server_remote_data_sources.dart';
import 'package:konek_frontend/features/selected_server/domain/repositories/selected_server_repository.dart';

class SelectedServerRepositoryImpl implements SelectedServerRepository {
  final SelectedServerRemoteDataSource _remoteDataSource;

  SelectedServerRepositoryImpl({required SelectedServerRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;
}
