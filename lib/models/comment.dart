class Comment {
  late int postId;
  late int id;
  late String name;
  late String email;
  late String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'] as int;
    id = json['id'] as int;
    name = json['name'] as String;
    email = json['email'] as String;
    body = json['body'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }
}
