class User {
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
  });

  final String id;
  final String username;
  final String email;
  final DateTime createdAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'created_at': createdAt.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
        other is User &&
        other.id == id &&
        other.username == username &&
        other.email == email &&
        other.createdAt == createdAt;
  
  @override
  int get hashCode => Object.hash(id, username, email, createdAt);

  @override
  String toString() =>
      'User(id: $id, username: $username, email: $email, createdAt: $createdAt)';
}