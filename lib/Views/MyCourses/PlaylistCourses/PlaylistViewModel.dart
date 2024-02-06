import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:rafeq_app/Views/Search/SearchModels/SearchYoutubeQuerying.dart';
import 'package:rafeq_app/services/AuthService.dart';
import 'package:rafeq_app/Views/Settings/LanguageProvider.dart';

class PlaylistViewModel extends ChangeNotifier {
  late final CollectionReference _playlistVideosCollection;
  List<VideoCard> _playlistVideos = [];
  List<VideoCard> get playlistVideos => _playlistVideos;
  final String userId;
  final VideoCard playlist; // Add a field for playlistId
  final LanguageProvider languageProvider;

  SearchYoutubeQuerying youtubeQuerying = SearchYoutubeQuerying();

  PlaylistViewModel(this.playlist, this.languageProvider)
      : userId = AuthService().currentUser?.uid ?? '' {
    _playlistVideosCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(playlist.timestamp)
        .collection("videos");

    notifyListeners();
    _loadPlaylistVideos();
  }

  _loadPlaylistVideos() async {
    var snapshots = await _playlistVideosCollection.get();
    _playlistVideos = snapshots.docs
        .map((doc) => VideoCard.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    if (_playlistVideos.isEmpty) {
      await _fetchAndStorePlaylistVideos();
    }
    // we will sort the _playlisVideos with the title
    _playlistVideos.sort((a, b) => a.title!.compareTo(b.title!));
    notifyListeners();
  }

  Future<void> _fetchAndStorePlaylistVideos() async {
    List<VideoCard> videosFromYouTube =
        await youtubeQuerying.fetchVideosFromYouTube(playlist.id ?? "");

    String totalVideosCount = videosFromYouTube.length.toString();
    playlist.totalVideos = totalVideosCount;
    updatePlaylistMetadata();
    for (var video in videosFromYouTube) {
      await _playlistVideosCollection.doc(video.id).set(video.toMap());
    }
    _playlistVideos.addAll(videosFromYouTube);
  }

  updateView() {
    notifyListeners();
  }

  void videoDone(VideoCard video) async {
    DocumentReference videoDocRef = _playlistVideosCollection.doc(video.id);

    try {
      await videoDocRef.update({'isSeen': true});

      // Mark the local video as seen
      video.isSeen = true;

      // Calculate the new count of completed videos
      int newCompletedCount =
          _playlistVideos.where((v) => v.isSeen == true).length;
      playlist.completedVideos = newCompletedCount.toString();
      // Update the completed videos count in Firestore
      await updatePlaylistMetadata();

      // Optionally, re-fetch the playlist videos to update the UI
      _loadPlaylistVideos();
    } catch (e) {
      print('Error updating video status: $e');
    }
  }

  Future<void> updatePlaylistMetadata() async {
    try {
      DocumentReference playlistDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(playlist.id ?? "");
      await playlistDocRef.update(playlist.toMap());
      // Optionally, refresh the playlist data if needed
    } catch (e) {
      print('Error updating playlist metadata: $e');
      // Handle errors (e.g., document not found, network issues)
    }
  }

  bool contains(VideoCard video) =>
      _playlistVideos.any((v) => v.id == video.id);
}
