import 'package:konek_frontend/features/servers/domain/entities/server_entity.dart';

class ServerModel extends ServerEntity {
  ServerModel({
    required super.id,
    required super.name,
    required super.description,
    required super.ownerId,
    super.iconUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      ownerId: json['ownerId'],
      iconUrl: json['iconUrl'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
