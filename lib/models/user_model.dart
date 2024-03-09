class UserModel {
  final String id;
  final String username;
  final int score;

  UserModel({
    required this.id,
    required this.username,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'score': score,
      };

  UserModel fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        username: json['username'],
        score: json['score'],
      );
}
