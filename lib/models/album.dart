class Album {
  late int userId;
  late int id;
  late String title;

  Album({required this.userId, required this.id, required this.title});

  Album.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] as int;
    id = json['id'] as int;
    title = json['title'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
