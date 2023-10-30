import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/Views/MyCourses/FavoritesModel.dart';
import 'package:rafeq_app/Views/Search/ContentCard.dart';

class MyCourses extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var favoritesModel = Provider.of<FavoritesModel>(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: favoritesModel.favorites.length,
        itemBuilder: (context, index) => ContentCard(video: favoritesModel.favorites[index]),
      ),
    );
  }
}
