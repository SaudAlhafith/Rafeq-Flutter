import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:rafeq_app/Views/MyCourses/FavoritesModel.dart';

class ContentCard extends StatelessWidget {
  final VideoCard video;

  ContentCard({required this.video});

  @override
  Widget build(BuildContext context) {
    var favoritesModel = Provider.of<FavoritesModel>(context);

    return Container(
      margin: const EdgeInsets.all(20),
      height: 330,
      decoration: BoxDecoration(
        color: Colors.white,
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
            child: SizedBox(width: 10, height: 330),
          ),
          Expanded(
            child: Column(
              children: [
                Image.network(
                  video.thumbnailURL,
                ),
                ContentCardData(video: video, favoritesModel: favoritesModel),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContentCardData extends StatelessWidget {
  const ContentCardData({
    super.key,
    required this.video,
    required this.favoritesModel,
  });

  final VideoCard video;
  final FavoritesModel favoritesModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Channel: ${video.channelTitle}'),
                  Text('Published: ${video.publishTime}'),
                  InkWell(
                    onTap: () async {
                      final Uri myUrl = Uri.parse('https://example.com'); // Replace with your URL

                      // You can add additional checks here to ensure it's a valid URL
                      if (myUrl.isAbsolute) {
                        bool canLaunchUrl = await canLaunch(myUrl.toString());
                        if (canLaunchUrl) {
                          launchUrl(myUrl);
                        } else {
                          // Handle the case when the URL cannot be launched
                          print('Could not launch $myUrl');
                        }
                      } else {
                        // Handle the case when the URL is not valid
                        print('Invalid URL: $myUrl');
                      }
                    },
                    child: Text(
                      video.typeForamatted,
                      style: TextStyle(
                        color: Color(0xFF1C96F9),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    favoritesModel.contains(video) ? Icons.add_circle : Icons.add,
                    color: favoritesModel.contains(video) ? Colors.blue : null,
                    size: 30,
                  ),
                  onPressed: () {
                    if (favoritesModel.contains(video)) {
                      favoritesModel.remove(video);
                    } else {
                      favoritesModel.add(video);
                    }
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
