import 'package:mobx/mobx.dart';
import 'package:pseudo_application/data/json_placeholder_api_impl.dart';
import 'package:pseudo_application/models/album.dart';
import 'package:pseudo_application/models/comment.dart';
import 'package:pseudo_application/models/photo.dart';
import 'package:pseudo_application/models/post.dart';
import 'package:pseudo_application/models/user.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final JsonPlaceholderApiImpl _api = JsonPlaceholderApiImpl();

  @observable
  ObservableList<Comment> listOfComments = ObservableList<Comment>();

  @action
  Future<List<User>> getListOfUsers() => _api.getListOfUsers();

  @action
  Future<List<Post>> getListOfUserPosts(int userId) =>
      _api.getListOfUserPosts(userId: userId);

  @action
  Future<List<Album>> getListOfUserAlbums(int userId) =>
      _api.getListOfUserAlbums(userId: userId);

  @action
  Future<List<Photo>> getListOfPhotosForAlbum(int albumId) =>
      _api.getListOfPhotosForAlbum(albumId: albumId);

  @action
  Future<List<Comment>> getListOfCommentsForPost(int postId) async {
    listOfComments.clear();
    listOfComments.addAll(await _api.getListOfCommentsForPost(postId: postId));
    return listOfComments;
  }

  @action
  Future<void> createCommentForPost({
    required int postId,
    required String name,
    required String text,
    required String email,
  }) async {
    final comment = await _api.createCommentForPost(
      postId: postId,
      name: name,
      text: text,
      email: email,
    );
    listOfComments.add(comment);
  }
}
