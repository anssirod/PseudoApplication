import 'package:flutter/material.dart';
import 'package:pseudo_application/main.dart';
import 'package:pseudo_application/models/album.dart';
import 'package:pseudo_application/models/post.dart';
import 'package:pseudo_application/models/user.dart';
import 'package:pseudo_application/screens/post_detailed_screen.dart';
import 'package:pseudo_application/screens/user_albums_screen.dart';
import 'package:pseudo_application/screens/user_posts_screen.dart';
import 'package:pseudo_application/stores/user_store.dart';
import 'package:pseudo_application/widgets/album_preview.dart';

import 'album_detailed_screen.dart';

class UserDetailedScreen extends StatelessWidget {
  final User currentUser;

  const UserDetailedScreen({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser.username),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserInfoSection(currentUser: currentUser),
              PostsSection(user: currentUser),
              AlbumsSection(user: currentUser)
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  final User currentUser;

  const UserInfoSection({Key? key, required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${currentUser.name}'),
          Text('Email: ${currentUser.email}'),
          Text('Phone: ${currentUser.phone}'),
          Text('Website: ${currentUser.website}'),
          Text('Company name: ${currentUser.company.name}'),
          Text('Company bs: ${currentUser.company.bs}'),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(
                  text: 'Catch phrase: ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: currentUser.company.catchPhrase,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Text('City: ${currentUser.address.city}'),
          Text('Street: ${currentUser.address.street}'),
          Text('Suite: ${currentUser.address.suite}'),
          Text('Zipcode: ${currentUser.address.zipcode}'),
          Text('Latitude: ${currentUser.address.geo.lat}'),
          Text('Longitude: ${currentUser.address.geo.lng}'),
        ],
      ),
    );
  }
}

class PostsSection extends StatelessWidget {
  final User user;

  const PostsSection({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Posts'),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserPostsScreen(
                        userId: user.id,
                      ),
                    ),
                  );
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        FutureBuilder<List<Post>>(
          future: getIt<UserStore>().getListOfUserPosts(user.id),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                return SizedBox(
                  height: 210,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailedScreen(
                                postId: snapshot.data![index].id,
                                postBody: snapshot.data![index].body,
                                postTitle: snapshot.data![index].title,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data![index].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        snapshot.data![index].body
                                            .replaceAll("\n", ""),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text('Empty data'));
              }
            } else {
              return Center(child: Text('State: ${snapshot.connectionState}'));
            }
          },
        ),
      ],
    );
  }
}

class AlbumsSection extends StatelessWidget {
  final User user;

  const AlbumsSection({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Albums'),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserAlbumsScreen(
                        userId: user.id,
                      ),
                    ),
                  );
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        FutureBuilder<List<Album>>(
          future: getIt<UserStore>().getListOfUserAlbums(user.id),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Album>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                return SizedBox(
                  height: 400,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlbumDetailedScreen(
                                  album: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                AlbumPreview(
                                  albumId: snapshot.data![index].id,
                                ),
                                Flexible(
                                  child: Text(
                                    snapshot.data![index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text('Empty data'));
              }
            } else {
              return Center(child: Text('State: ${snapshot.connectionState}'));
            }
          },
        ),
      ],
    );
  }
}
