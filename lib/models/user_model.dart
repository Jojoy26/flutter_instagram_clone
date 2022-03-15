import 'dart:convert';

class UserModel {
  final String username;
  final String profile;
  final String bio;
  final List<String> followers;
  final List<String> following;
  final bool me;
  final bool isFollowing;
  final int posts;
  UserModel({
    required this.username,
    required this.profile,
    required this.bio,
    required this.followers,
    required this.following,
    required this.me,
    required this.isFollowing,
    required this.posts,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'profile': profile,
      'bio': bio,
      'followers': followers,
      'following': following,
      'isFollowing': isFollowing,
      'posts': posts
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      profile: map['profile'] ?? '',
      bio: map['bio'] ?? '',
      followers: map["followers"] != null ? List<String>.from(map['followers']) : [],
      following: map["following"] != null ? List<String>.from(map['following']) : [],
      me: map["me"],
      isFollowing: map["isFollowing"],
      posts: int.parse(map["posts"])
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
