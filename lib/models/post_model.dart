import 'dart:convert';

class PostModel {
  final int id;
  final List<String> media;
  final String caption;
  List<String> likes;
  bool isLiked;
  final String time;
  final String profile;
  final String username;
  final List<Comment> comments;
  PostModel({
    required this.id,
    required this.media,
    required this.caption,
    required this.likes,
    required this.isLiked,
    required this.time,
    required this.profile,
    required this.username,
    required this.comments,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: int.parse(map['id']),
      media: List<String>.from(map['media']),
      caption: map['caption'] ?? '',
      likes: map["likes"] != null ? List<String>.from(map['likes']) : [],
      isLiked: map['isLiked'] ?? false,
      time: map['time'] ?? '',
      profile: map['profile'] ?? '',
      username: map['username'] ?? '',
      comments: map["comments"] != null ? List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))) : [],
    );
  }

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'media': media,
      'caption': caption,
      'likes': likes,
      'isLiked': isLiked,
      'time': time,
      'profile': profile,
      'username': username,
      'comments': comments.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

class Comment {
  final String username;
  final String profile;
  final String comment;
  final String time;
  Comment({
    required this.username,
    required this.profile,
    required this.comment,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'profile': profile,
      'comment': comment,
      'time': time,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      username: map['username'] ?? '',
      profile: map['profile'] ?? '',
      comment: map['comment'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));
}
