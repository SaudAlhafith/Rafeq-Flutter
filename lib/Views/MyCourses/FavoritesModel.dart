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

  updateView() {
    notifyListeners();
  }

  List<VideoCard> get favorites => _favorites;

  void add(VideoCard video) async {
    DateTime now = DateTime.now();
    video.timestamp = now.toIso8601String();  // Adding the timestamp to the existing video card

    await _favoritesCollection.doc(now.toIso8601String()).set(video.toMap());
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
