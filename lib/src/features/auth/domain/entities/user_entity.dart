class UserEntity {
  final String id;
  final String name;
  final String email;
  final DateTime created;
  final DateTime updated;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.created,
    required this.updated,
  });
}
