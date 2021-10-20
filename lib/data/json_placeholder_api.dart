import 'package:pseudo_application/models/album.dart';
import 'package:pseudo_application/models/comment.dart';
import 'package:pseudo_application/models/photo.dart';
import 'package:pseudo_application/models/post.dart';
import 'package:pseudo_application/models/user.dart';

abstract class JsonPlaceholderApi {
  Future<List<User>> getListOfUsers();

  Future<List<Post>> getListOfUserPosts({required int userId});

  Future<List<Album>> getListOfUserAlbums({required int userId});

  Future<List<Photo>> getListOfPhotosForAlbum({required int albumId});

  Future<List<Comment>> getListOfCommentsForPost({required int postId});

  Future<Comment> createCommentForPost({
    required int postId,
    required String name,
    required String text,
    required String email,
  });
}
