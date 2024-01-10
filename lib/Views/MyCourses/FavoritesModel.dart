// import 'package:flutter/foundation.dart';
// import 'package:rafeq_app/DataModel/VideoCard.dart';

// class FavoritesModel extends ChangeNotifier {
//   List<VideoCard> _favorites = [];

//   List<VideoCard> get favorites => _favorites;

//   void add(VideoCard video) {
//     _favorites.add(video);
//     notifyListeners();
//   }

//   void remove(VideoCard video) {
//     _favorites.remove(video);
//     notifyListeners();
//   }

//   bool contains(VideoCard video) => _favorites.contains(video);
// }

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:rafeq_app/services/AuthService.dart';

class FavoritesModel extends ChangeNotifier {
  late final CollectionReference _favoritesCollection;
  List<VideoCard> _favorites = [];
  final String userId;

  FavoritesModel() : userId = AuthService().currentUser?.uid ?? '' {
    _favoritesCollection = FirebaseFirestore.instance.collection('users').doc(userId).collection('favorites');
    _loadFavorites();
  }

  // Method to load favorites from Firestore.
  _loadFavorites() async {
    var snapshots = await _favoritesCollection.get();
    _favorites = snapshots.docs.map((doc) => VideoCard.fromMap(doc.data() as Map<String, dynamic>)).toList();
    notifyListeners();
  }

  List<VideoCard> get favorites => _favorites;

  void add(VideoCard video) async {
    // await _favoritesCollection.add(video.toMap());

    // here we are adding the video to the favorites collection and his id is the timestamp at the click moment
    await _favoritesCollection.doc(Timestamp.fromDate(DateTime.now()).seconds.toString()).set(video.toMap());
    _loadFavorites();
  }

  void remove(VideoCard video) async {
    var snapshots = await _favoritesCollection.where('id', isEqualTo: video.id).get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    _loadFavorites();
  }

  bool contains(VideoCard video) => _favorites.any((v) => v.id == video.id);
}
