import 'package:flutter/foundation.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';

class FavoritesModel extends ChangeNotifier {
  List<VideoCard> _favorites = [];

  List<VideoCard> get favorites => _favorites;

  void add(VideoCard video) {
    _favorites.add(video);
    notifyListeners();
  }

  void remove(VideoCard video) {
    _favorites.remove(video);
    notifyListeners();
  }

  bool contains(VideoCard video) => _favorites.contains(video);
}
