import 'dart:convert';

class UserSearchModel {
  final String username;
  final String profile;
  UserSearchModel({
    required this.username,
    required this.profile,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'profile': profile,
    };
  }

  factory UserSearchModel.fromMap(Map<String, dynamic> map) {
    return UserSearchModel(
      username: map['username'] ?? '',
      profile: map['profile'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSearchModel.fromJson(String source) => UserSearchModel.fromMap(json.decode(source));
}
