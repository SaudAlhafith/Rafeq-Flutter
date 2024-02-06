import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/Views/MyCourses/CourseVideosUI.dart';
import 'package:rafeq_app/Views/MyCourses/FavoritesModel.dart';
import 'package:rafeq_app/Views/MyCourses/CoursesInFavorites.dart';
import 'package:rafeq_app/Views/MyCourses/PlaylistCourses/PlaylistDetailsScreen.dart';
import 'package:rafeq_app/Views/MyCourses/PlaylistCourses/PlaylistViewModel.dart';
import 'package:rafeq_app/Views/Settings/LanguageProvider.dart';

class MyCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoritesModel = Provider.of<FavoritesModel>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);

    // Assuming each favorite has a 'type' property which can be 'playlist' or 'video'
    var playlists =
        favoritesModel.favorites.where((f) => f.type == 'playlist').toList();
    var videos =
        favoritesModel.favorites.where((f) => f.type == 'video').toList();

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              languageProvider.translate("Courses"),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final playlist = playlists[index];

                  return Dismissible(
                    key: Key(playlist.id!),
                    onDismissed: (direction) {
                      favoritesModel.remove(playlist);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) =>
                                  PlaylistViewModel(playlist, languageProvider),
                              child: PlaylistDetailsScreen(
                                playlist: playlist,
                              ),
                            ),
                          ),
                        );
                      },
                      child: CoursesInFavorites(video: playlist),
                    ),
                  );
                },
              ),
            ),
            // Text(
            //   languageProvider.translate("Videos"),
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: videos.length,
            //     itemBuilder: (context, index) {
            //       final video = videos[index];

            //       return Dismissible(
            //         key: Key(video
            //             .id!), // Ensure you have a unique key for each item. 'id' should be unique.
            //         onDismissed: (direction) {
            //           // Remove the item from the list
            //           favoritesModel.remove(video);
            //           // You can also implement additional actions like showing a snackbar or updating backend data here.
            //         },
            //         background: Container(
            //           color: Colors.red,
            //           alignment: Alignment.centerRight,
            //           child: Padding(
            //             padding: EdgeInsets.only(right: 20.0),
            //             child: Icon(Icons.delete, color: Colors.white),
            //           ),
            //         ),
            //         child: CourseVideosUI(video: video),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
