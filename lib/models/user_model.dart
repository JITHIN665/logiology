class User {
  String username;
  String password;
  String? profileImage;

  User({
    required this.username,
    required this.password,
    this.profileImage,
  });
}