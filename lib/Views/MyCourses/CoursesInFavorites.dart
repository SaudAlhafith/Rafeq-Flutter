import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:rafeq_app/Views/MyCourses/FavoritesModel.dart';
import 'package:rafeq_app/Views/Search/SearchResultModel.dart';
import 'package:rafeq_app/Views/Settings/DarkThemeProvider.dart';

import '../Search/ContentCard.dart';

class CoursesInFavorites extends StatelessWidget {
  final VideoCard video;

  CoursesInFavorites({required this.video});

  @override
  Widget build(BuildContext context) {
    final darkThemeProvider = Provider.of<DarkThemeProvider>(context);
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: darkThemeProvider.isDarkModeEnabled
                    ? Color(0xff303030)
                    : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xff1C96F9),
                Color(0xff3351C5),
                Color(0xff27D1B3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          Expanded(
            child: Row(
                children: [
                  Container(
                    width: 150,
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), // Adjust the value for desired curvature
                      child: Image.network(
                        video.thumbnailURL ?? "",
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: ContentCardData(video: video, size: 2),
                    ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}


