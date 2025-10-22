import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';

class ServerCreateRequest extends ServerEntity {
  ServerCreateRequest({required super.name, super.description = '', super.iconUrl = ''})
    : super(id: '', ownerId: '', createdAt: DateTime.now(), updatedAt: DateTime.now());

  Map<String, dynamic> toJson() {
    return {
      'name': name.trim(),
      'description': description.trim().isEmpty ? null : description,
      'iconUrl': iconUrl,
    };
  }
}
