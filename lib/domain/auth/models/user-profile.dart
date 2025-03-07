class UserProfile {
  String email;
  List<String> roles;

  UserProfile({
    required this.email,
    required this.roles,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json['email'],
      roles: List<String>.from(json['roles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'roles': this.roles,
    };
  }
}
