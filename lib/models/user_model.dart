class UserModel{
  final String username;
  final int score;


  UserModel({
    required this.username,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'score': score,
  };

  UserModel fromJson(Map<String, dynamic> json) => UserModel(
    username: json['username'],
    score: json['score'],
  );
}