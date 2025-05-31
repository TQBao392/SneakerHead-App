class Profile {
  final String name;
  final String username;
  final String userId;
  final String email;
  final String phoneNumber;
  final String gender;
  final String dob;
  final String avatarUrl;
  final String? address;

  Profile({
    required this.name,
    required this.username,
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.dob,
    required this.avatarUrl,
    this.address,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String,
      username: json['username'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
      dob: json['dob'] as String,
      avatarUrl: json['avatarUrl'] as String,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'userId': userId,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dob': dob,
      'avatarUrl': avatarUrl,
      'address': address,
    };
  }
}