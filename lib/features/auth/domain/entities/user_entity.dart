import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String email;
  final String userName;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.userId,
    required this.email,
    required this.userName,
    this.avatarUrl,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    userId,
    email,
    userName,
    avatarUrl,
    createdAt,
    updatedAt,
  ];
}
