import 'package:flutter/material.dart';
import 'package:pseudo_application/main.dart';
import 'package:pseudo_application/models/album.dart';
import 'package:pseudo_application/models/photo.dart';
import 'package:pseudo_application/stores/user_store.dart';

class AlbumDetailedScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailedScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  album.title,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                FutureBuilder<List<Photo>>(
                  future: getIt<UserStore>().getListOfPhotosForAlbum(album.id),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Photo>> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else if (snapshot.hasData) {
                        return GridView.count(
                          childAspectRatio: itemWidth / itemHeight,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          children:
                              List.generate(snapshot.data!.length, (index) {
                            return Card(
                              child: Column(
                                children: [
                                  Image.network(
                                    snapshot.data![index].url,
                                    width: 80,
                                    height: 80,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(snapshot.data![index].title),
                                  )
                                ],
                              ),
                            );
                          }),
                        );
                      } else {
                        return const Center(child: Text('Empty data'));
                      }
                    } else {
                      return Center(
                        child: Text('State: ${snapshot.connectionState}'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
