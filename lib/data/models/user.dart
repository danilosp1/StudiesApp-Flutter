class User {
  final String username;
  final String passwordHash;

  User({required this.username, required this.passwordHash});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      passwordHash: json['passwordHash'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'passwordHash': passwordHash,
    };
  }
}