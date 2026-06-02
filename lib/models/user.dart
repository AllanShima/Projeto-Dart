class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'createdAt': createdAt.toIso8601String(),
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'] as String,
    name: map['name'] as String,
    email: map['email'] as String,
    createdAt: DateTime.parse(map['createdAt'] as String),
  );

  User copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is User && other.id == id;

  @override
  int get hashCode => Object.hash(id, name, email, createdAt);

  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, createdAt: $createdAt)';
}
