import 'package:konek_frontend/features/selected_server/domain/entities/selected_server_entity.dart';
import 'package:konek_frontend/features/servers/data/models/server_model.dart';

class SelectedServerModel extends SelectedServerEntity {
  const SelectedServerModel({ServerModel? server}) : super(server: server);

  factory SelectedServerModel.fromJson(Map<String, dynamic> json) {
    return SelectedServerModel();
  }
}
