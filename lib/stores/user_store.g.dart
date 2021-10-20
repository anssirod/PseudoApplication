// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$listOfCommentsAtom = Atom(name: '_UserStore.listOfComments');

  @override
  ObservableList<Comment> get listOfComments {
    _$listOfCommentsAtom.reportRead();
    return super.listOfComments;
  }

  @override
  set listOfComments(ObservableList<Comment> value) {
    _$listOfCommentsAtom.reportWrite(value, super.listOfComments, () {
      super.listOfComments = value;
    });
  }

  final _$getListOfUsersAsyncAction = AsyncAction('_UserStore.getListOfUsers');

  @override
  Future<List<User>> getListOfUsers() {
    return _$getListOfUsersAsyncAction.run(() => super.getListOfUsers());
  }

  final _$getListOfUserPostsAsyncAction =
      AsyncAction('_UserStore.getListOfUserPosts');

  @override
  Future<List<Post>> getListOfUserPosts(int userId) {
    return _$getListOfUserPostsAsyncAction
        .run(() => super.getListOfUserPosts(userId));
  }

  final _$getListOfCommentsForPostAsyncAction =
      AsyncAction('_UserStore.getListOfCommentsForPost');

  @override
  Future<List<Comment>> getListOfCommentsForPost(int postId) {
    return _$getListOfCommentsForPostAsyncAction
        .run(() => super.getListOfCommentsForPost(postId));
  }

  final _$createCommentForPostAsyncAction =
      AsyncAction('_UserStore.createCommentForPost');

  @override
  Future<void> createCommentForPost(
      {required int postId,
      required String name,
      required String text,
      required String email}) {
    return _$createCommentForPostAsyncAction.run(() => super
        .createCommentForPost(
            postId: postId, name: name, text: text, email: email));
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  Future<List<Album>> getListOfUserAlbums(int userId) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.getListOfUserAlbums');
    try {
      return super.getListOfUserAlbums(userId);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<List<Photo>> getListOfPhotosForAlbum(int albumId) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.getListOfPhotosForAlbum');
    try {
      return super.getListOfPhotosForAlbum(albumId);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listOfComments: ${listOfComments}
    ''';
  }
}
