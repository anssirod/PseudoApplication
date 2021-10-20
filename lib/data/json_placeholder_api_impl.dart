import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pseudo_application/models/album.dart';
import 'package:pseudo_application/models/comment.dart';
import 'package:pseudo_application/models/photo.dart';
import 'package:pseudo_application/models/post.dart';
import 'package:pseudo_application/models/user.dart';

import 'json_placeholder_api.dart';

class JsonPlaceholderApiImpl extends JsonPlaceholderApi {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<User>> getListOfUsers() async {
    const url = '$baseUrl/users';

    final http.Response response;
    try {
      response = await http.get(
        Uri.parse(url),
      );
    } catch (e) {
      rethrow;
    }

    if (response.statusCode == 200) {
      final List? jsonResponse = jsonDecode(response.body) as List<dynamic>?;
      return jsonResponse!
          .map((user) => User.fromJson(user as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<Post>> getListOfUserPosts({required int userId}) async {
    const url = '$baseUrl/posts';

    final http.Response response;
    try {
      response = await http.get(
        Uri.parse(url),
      );
    } catch (e) {
      rethrow;
    }

    if (response.statusCode == 200) {
      final List? jsonResponse = jsonDecode(response.body) as List<dynamic>?;
      return jsonResponse!
          .map((post) => Post.fromJson(post as Map<String, dynamic>))
          .where((post) => post.userId == userId)
          .toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<Album>> getListOfUserAlbums({required int userId}) async {
    const url = '$baseUrl/albums';

    final http.Response response;
    try {
      response = await http.get(
        Uri.parse(url),
      );
    } catch (e) {
      rethrow;
    }

    if (response.statusCode == 200) {
      final List? jsonResponse = jsonDecode(response.body) as List<dynamic>?;
      return jsonResponse!
          .map((album) => Album.fromJson(album as Map<String, dynamic>))
          .where((album) => album.userId == userId)
          .toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<Photo>> getListOfPhotosForAlbum({required int albumId}) async {
    const url = '$baseUrl/photos';

    final http.Response response;
    try {
      response = await http.get(
        Uri.parse(url),
      );
    } catch (e) {
      rethrow;
    }

    if (response.statusCode == 200) {
      final List? jsonResponse = jsonDecode(response.body) as List<dynamic>?;
      return jsonResponse!
          .map((photos) => Photo.fromJson(photos as Map<String, dynamic>))
          .where((photos) => photos.albumId == albumId)
          .toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<Comment>> getListOfCommentsForPost({required int postId}) async {
    const url = '$baseUrl/comments';

    final http.Response response;
    try {
      response = await http.get(
        Uri.parse(url),
      );
    } catch (e) {
      rethrow;
    }

    if (response.statusCode == 200) {
      final List? jsonResponse = jsonDecode(response.body) as List<dynamic>?;
      return jsonResponse!
          .map((comments) => Comment.fromJson(comments as Map<String, dynamic>))
          .where((post) => post.postId == postId)
          .toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<Comment> createCommentForPost({
    required int postId,
    required String name,
    required String text,
    required String email,
  }) async {
    const url = '$baseUrl/posts';

    final headers = <String, String>{
      HttpHeaders.acceptHeader: ContentType.json.mimeType,
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
    };

    final body = <String, dynamic>{
      'email': email,
      'name': name,
      'body': text,
      'postId': postId,
    };

    final http.Response response;
    try {
      response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
    } catch (e) {
      rethrow;
    }

    if (response.statusCode == 201) {
      return Comment.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception(response.body);
    }
  }
}
