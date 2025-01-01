class UserEntity {
  final String userId;
  final DateTime createdAt;
  final String fullName;
  final List<String> role;
  final String location;
  final List<String> goals;

  UserEntity({
    required this.userId,
    required this.createdAt,
    required this.fullName,
    required this.role,
    required this.location,
    required this.goals,
  });
}
