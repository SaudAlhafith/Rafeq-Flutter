import 'package:flutter/foundation.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:rafeq_app/Views/Search/SearchModels/SearchYoutubeQuerying.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultModel extends ChangeNotifier {
  // create an instance of youtube querying class
  SearchYoutubeQuerying youtubeQuerying = SearchYoutubeQuerying();

  List<VideoCard> _searchResult = [];

  List<VideoCard> get searchResult => _searchResult;

  String searchCode = "";
  String searchCourse = "";
  String searchLesson = "";
  String textContent = "Eng";

  String warningMessage = "";
  bool isShowingWarning = false;

  Future<void> searchYoutube() async {
    String contentType = "playlist";
    String searchQuery = "";

    // if (searchCode == "") {
    //   showWarning("الرجاء إدخال رمز المادة.");
    //   clearResults();
    //   return;
    // }

    bool isArabic(String text) {
      RegExp arabic = RegExp(r'[\u0600-\u06FF]');
      return arabic.hasMatch(text);
    }

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
    clearResults();
    _searchResult = await youtubeQuerying.fetchYoutubeData(searchQuery, contentType);
  }

  void changeSearchQuery({
    required String newSearchCode,
    required String newSearchCourse,
    String? newSearchLesson,
  }) async {
    searchCode = newSearchCode;
    searchCourse = newSearchCourse;
    searchLesson = newSearchLesson ?? "";
    notifyListeners();
    await searchYoutube();
    notifyListeners();
  }

  void toggleTextContext() {
    if (textContent == 'Eng') {
      textContent = 'عربي';
    } else {
      textContent = 'Eng';
    }
    notifyListeners();
  }

  void hideWarning() {
    isShowingWarning = false;
    notifyListeners();
  }

  void showWarning(String message) {
    warningMessage = message;
    isShowingWarning = true;
    notifyListeners();
  }

  void clearResults() {
    _searchResult = [];
    notifyListeners();
  }

  void openUrl(
    String urlString,
  ) async {
    final Uri myUrl = Uri.parse(urlString); // Replace with your URL
    // You can add additional checks here to ensure it's a valid URL
    if (myUrl.isAbsolute) {
      bool isLaunchable = await canLaunchUrl(myUrl);
      if (isLaunchable) {
        launchUrl(myUrl);
      } else {
        // Handle the case when the URL cannot be launched
        print('Could not launch $myUrl');
      }
    } else {
      // Handle the case when the URL is not valid
      print('Invalid URL: $myUrl');
    }
  }
}
