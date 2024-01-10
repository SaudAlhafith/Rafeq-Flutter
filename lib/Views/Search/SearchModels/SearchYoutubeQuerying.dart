import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:http/http.dart' as http;
import 'package:rafeq_app/Views/Search/SearchResultModel.dart';
import 'dart:convert';

extension SearchYoutubeQuerying on SearchResultModel {
  bool isArabic(String text) {
    RegExp arabic = RegExp(r'[\u0600-\u06FF]');
    return arabic.hasMatch(text);
  }

  void searchYoutube() async {
    String contentType = "playlist";
    String searchQuery = "";

    // if (searchCode == "") {
    //   showWarning("الرجاء إدخال رمز المادة.");
    //   clearResults();
    //   return;
    // }

    if (searchCourse == "") {
      showWarning("الرجاء إدخال اسم المادة.");
      clearResults();
      return;
    }

    if (searchLesson != "") {
      if (isArabic(searchLesson) && textContent == 'Eng') {
        showWarning("الرجاء إدخال اسم الدرس باللغة الإنجليزية.");
        clearResults();
        return;
      } else if (!isArabic(searchLesson) && textContent == 'عربي') {
        showWarning("الرجاء إدخال اسم الدرس باللغة العربية.");
        clearResults();
        return;
      }
      contentType = "video";
    }

    hideWarning();
    if (searchLesson != "") {
      searchQuery = searchCourse + " " + searchLesson;
    } else {
      searchQuery = searchCourse;
    }
    // Cal;ling the fetchYoutubeData
    await fetchYoutubeData(searchQuery, contentType);
  }

  Future<void> fetchYoutubeData(String query, String contentType) async {
    final Uri url = Uri.parse('https://www.googleapis.com/youtube/v3/search?key=$API_KEY&type=$contentType&part=snippet&maxResults=10&q=$query');

    try {
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        displayResults(data['items'], contentType);
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  String formatDate(String isoDateString) {
    final date = DateTime.parse(isoDateString);
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day-$month-$year';
  }

  void displayResults(List<dynamic> items, String type) {
    clearResults();

    if (items.length > 0) {
      items.forEach((item) {
        String id;
        String linkURL;
        String thumbnailURL;

        final String title = item['snippet']['title'];
        final channelTitle = item['snippet']['channelTitle'];
        // Assuming you have a Dart version of formatDate
        final publishTime = formatDate(item['snippet']['publishTime']);
        thumbnailURL = item['snippet']['thumbnails']['medium']['url'];
        linkURL = '';
        id = '';
        if (type == 'playlist') {
          id = item['id']['playlistId'];
          linkURL = 'https://www.youtube.com/playlist?list=$id';
        } else if (type == 'video') {
          id = item['id']['videoId'];
          linkURL = 'https://www.youtube.com/watch?v=$id';
        }

        searchResult.add(VideoCard(
          id: id,
          title: title,
          channelTitle: channelTitle,
          publishTime: publishTime,
          thumbnailURL: thumbnailURL,
          linkURL: linkURL,
          type: type,
          listStatus: 'none',
        ));
      });
    } else {
      // Handle the case where `items` is not defined or is not a list
      // You might handle this in your UI logic or by using some state management approach
      print("No results found.");
    }
  }
}
