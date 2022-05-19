class Users {
  final String content;
  final String id;
  final String title;

  const Users({
    required this.content,
    required this.id,
    required this.title,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      content: json['content'],
      id: json['id'],
      title: json['title'],
    );
  }
}
