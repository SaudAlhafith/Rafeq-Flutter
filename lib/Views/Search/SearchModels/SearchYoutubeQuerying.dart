// ignore_for_file: avoid_print

import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:http/http.dart' as http;
import 'package:rafeq_app/Views/Search/SearchResultModel.dart';
import 'dart:convert';

class SearchYoutubeQuerying {
  final API_KEY = 'AIzaSyBM4mERZV8sBdua6VQ5LYDlTZ7Ya4HyiQM';

  Future<List<VideoCard>> fetchYoutubeData(String query, String contentType) async {
    final Uri url = Uri.parse('https://www.googleapis.com/youtube/v3/search?key=$API_KEY&type=$contentType&part=snippet&maxResults=10&q=$query');

    try {
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return displayResults(data['items'], contentType);
      } else {
        print('Error fetching data: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching data: $error');
      return [];
    }
  }

  Future<List<VideoCard>> fetchVideosFromYouTube(String playlistId) async {
    print("Getting playlist's videos from Youtube");
    final Uri url = Uri.parse('https://www.googleapis.com/youtube/v3/playlistItems?key=$API_KEY&playlistId=$playlistId&part=snippet&maxResults=10');
    try {
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return displayResults(data["items"], "videopl");
      } else {
        print('Error fetching playlist videos: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching playlist videos: $error');
      return [];
    }
  }

  Future<void> fetchPlaylistVideos(String playlistId) async {
    final Uri url = Uri.parse('https://www.googleapis.com/youtube/v3/playlistItems?key=$API_KEY&playlistId=$playlistId&part=snippet&maxResults=10');

    try {
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        displayResults(data['items'], "video");
      } else {
        print('Error fetching playlist videos: ${response.statusCode}');
        // Optionally, show a warning using showWarning method
      }
    } catch (error) {
      print('Error fetching playlist videos: $error');
      // Optionally, show a warning using showWarning method
    }
  }

  String formatDate(String isoDateString) {
    final date = DateTime.parse(isoDateString);
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day-$month-$year';
  }

  List<VideoCard> displayResults(List<dynamic> items, String type) {
    List<VideoCard> _searchResult = [];
    if (items.length > 0) {
      items.forEach((item) {
        String id;
        String linkURL;
        String thumbnailURL;
        final String title = item['snippet']['title'];
        final channelTitle = item['snippet']['channelTitle'];
        // Assuming you have a Dart version of formatDate
        final publishTime = formatDate(item['snippet'][type == "videopl" ? 'publishedAt' : 'publishTime']);
        thumbnailURL = item['snippet']['thumbnails']['medium']['url'];
        linkURL = '';
        id = '';
        if (type == 'playlist') {
          id = item['id']['playlistId'];
          linkURL = 'https://www.youtube.com/playlist?list=$id';
        } else if (type == 'video') {
          id = item['id']['videoId'];
          linkURL = 'https://www.youtube.com/watch?v=$id';
        } else if (type == "videopl") {
          id = item['snippet']['resourceId']['videoId'];
          linkURL = 'https://www.youtube.com/watch?v=$id';
        }

        _searchResult.add(VideoCard(
          id: id,
          title: title,
          channelTitle: channelTitle,
          publishTime: publishTime,
          thumbnailURL: thumbnailURL,
          linkURL: linkURL,
          type: type,
          listStatus: 'none',
          isSeen: false,
        ));
      });
      return _searchResult;
    } else {
      // Handle the case where `items` is not defined or is not a list
      // You might handle this in your UI logic or by using some state management approach
      print("No results found.");
      return [];
    }
  }
}
