import 'package:flutter/material.dart';
import 'package:pseudo_application/main.dart';
import 'package:pseudo_application/models/album.dart';
import 'package:pseudo_application/stores/user_store.dart';
import 'package:pseudo_application/widgets/album_preview.dart';

import 'album_detailed_screen.dart';

class UserAlbumsScreen extends StatelessWidget {
  final int userId;

  const UserAlbumsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Album>>(
        future: getIt<UserStore>().getListOfUserAlbums(userId),
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
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
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
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
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
              );
            } else {
              return const Center(child: Text('Empty data'));
            }
          } else {
            return Center(child: Text('State: ${snapshot.connectionState}'));
          }
        },
      ),
    );
  }
}
