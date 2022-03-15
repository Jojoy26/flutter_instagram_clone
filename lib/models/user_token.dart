class UserToken {
  final String token;
  UserToken({
    required this.token,
  });

  Map<String, dynamic> toMap() => {
    "x-auth-token": token
  };
}
