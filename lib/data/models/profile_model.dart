class Profile {
  final String name;
  final String username;
  final String userId;
  final String email;
  final String phoneNumber;
  final String gender;
  final String dob;
  final String avatarUrl;

  Profile({
    required this.name,
    required this.username,
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.dob,
    required this.avatarUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      username: json['username'],
      userId: json['userId'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      dob: json['dob'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
