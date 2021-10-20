import 'package:flutter/material.dart';
import 'package:pseudo_application/models/photo.dart';
import 'package:pseudo_application/stores/user_store.dart';

import '../main.dart';

class AlbumPreview extends StatelessWidget {
  const AlbumPreview({Key? key, required this.albumId}) : super(key: key);

  final int albumId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
      future: getIt<UserStore>().getListOfPhotosForAlbum(albumId),
      builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            return SizedBox(
              height: 100,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.network(
                      snapshot.data![0].url,
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Empty data'));
          }
        } else {
          return Center(child: Text('State: ${snapshot.connectionState}'));
        }
      },
    );
  }
}
