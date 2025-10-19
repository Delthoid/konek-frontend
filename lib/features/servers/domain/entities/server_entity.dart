class ServerEntity {
  final String id;
  final String name;
  final String description;
  final String ownerId;
  final String? iconUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  ServerEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.ownerId,
    this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}