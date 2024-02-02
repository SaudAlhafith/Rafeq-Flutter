import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:rafeq_app/Views/MyCourses/CourseVideosUI.dart';
import 'package:rafeq_app/Views/MyCourses/PlaylistCourses/PlaylistViewModel.dart';

class PlaylistDetailsScreen extends StatelessWidget {
  final VideoCard playlist;

  PlaylistDetailsScreen({required this.playlist});

  @override
  Widget build(BuildContext context) {
    var playlistModel = Provider.of<PlaylistViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.title ??
            "null"), // Assuming 'playlist' has a 'title' property
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const Text(
              "Course Videos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: playlistModel.playlistVideos
                    .length, // Assuming 'playlist' has a list of videos
                itemBuilder: (context, index) {
                  return CourseVideosUI(
                      video: playlistModel.playlistVideos[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
