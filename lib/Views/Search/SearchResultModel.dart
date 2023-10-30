import 'package:flutter/foundation.dart';
import 'package:rafeq_app/Constants/Constants.dart';
import 'package:rafeq_app/DataModel/VideoCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class SearchResultModel extends ChangeNotifier {
  final API_KEY = 'AIzaSyBM4mERZV8sBdua6VQ5LYDlTZ7Ya4HyiQM';

  List<VideoCard> _searchResult = [];

  List<VideoCard> get searchResult => _searchResult;

  String searchCode = "";
  String searchCourse = "";
  String searchLesson = "";
  String textContent = "Eng";

  String warningMessage = "";
  bool isShowingWarning = false;

  void toggleTextContext() {
    if (textContent == 'Eng') {
      textContent = 'عربي';
    } else {
      textContent = 'Eng';
    }
    notifyListeners();
  }

  void openUrl(String urlString,) async {
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
}


  void changeSearchQuery({
    required String newSearchCode,
    required String newSearchCourse,
    String? newSearchLesson,
  }) async {
    searchCode = newSearchCode;
    searchCourse = newSearchCourse;
    searchLesson = newSearchLesson ?? "";
    // searchResult.add(VideoCard(thumbnailURL: "https://i.ytimg.com/vi/M3Na5luSx50/mqdefault.jpg", title: "hello", channelTitle: "gasdgas", publishTime: "2003-42-4", linkURL: "linkURL", type: "type"));
    notifyListeners();
    searchYoutube();
    notifyListeners();
  }

  bool isArabic(String text) {
    RegExp arabic = RegExp(r'[\u0600-\u06FF]');
    return arabic.hasMatch(text);
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

  void searchYoutube() async {
    String contentType = "playlist";
    String searchQuery = "";

    if (searchCode == "") {
      showWarning("الرجاء إدخال رمز المادة.");
      clearResults();
      return;
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
        if (type == 'playlist') {
          id = item['id']['playlistId'];
          linkURL = 'https://www.youtube.com/playlist?list=$id';
        } else if (type == 'video') {
          id = item['id']['videoId'];
          linkURL = 'https://www.youtube.com/watch?v=$id';
        }

        searchResult.add(VideoCard(
          title: title,
          channelTitle: channelTitle,
          publishTime: publishTime,
          thumbnailURL: thumbnailURL,
          linkURL: linkURL,
          type: type,
        ));
      });
    } else {
      // Handle the case where `items` is not defined or is not a list
      // You might handle this in your UI logic or by using some state management approach
      print("No results found.");
    }
  }

  void hideWarning() {
    isShowingWarning = false;
    notifyListeners();
  }

  // translateText(text, targetLanguage, callback) {
  //   // Check if translation exists in the courseTranslations dictionary
  //   var translatedText = Constants.courseTranslations[text] ?? "";

  //   if (translatedText == "") {
  //     showWarning("الرجاء إدخال اسم مادة صحيح.");
  //     return;
  //   }

  //   // If translation exists, and target language is English, use the provided translation
  //   if (translatedText != "" && targetLanguage == 'en') {
  //     callback(translatedText);
  //     return;
  //   }

  //   // If translation doesn't exist, or target language is Arabic, return the original text
  //   if (translatedText == "" || targetLanguage == 'ar') {
  //     callback(text);
  //     return;
  //   }
  // }
}



// const API_KEY = 'AIzaSyBM4mERZV8sBdua6VQ5LYDlTZ7Ya4HyiQM';


// var label = document.getElementById('language-label');

// function isArabic(text) {
//     var arabicPattern = /[\u0600-\u06FF]/;
//     return arabicPattern.test(text);
// }

// function clearResults() {
//     const resultsDiv = document.getElementById('results');
//     resultsDiv.innerHTML = ''; // clear previous results
// }

// function translateText(text, targetLanguage, callback) {
//     // Check if translation exists in the courseTranslations dictionary
//     let translatedText = courseTranslations[text];

//     if (!translatedText) {
//         showWarning("الرجاء إدخال اسم مادة صحيح.");
//         return;
//     }

//     // If translation exists, and target language is English, use the provided translation
//     if (translatedText && targetLanguage === 'en') {
//         callback(translatedText);
//         return;
//     } 

//     // If translation doesn't exist, or target language is Arabic, return the original text
//     if (!translatedText || targetLanguage === 'ar') {
//         callback(text);
//         return;
//     }
// }


// function toggleLanguage() {
//     if (label.textContent === 'Eng') {
//         label.textContent = 'عربي';
//     } else {
//         label.textContent = 'Eng';
//     }
// }



// function searchYouTube() {
//     const searchCode = document.getElementById('searchCode').value;
//     let searchCourse = document.getElementById('searchCourse').value;
//     let searchLesson = document.getElementById('searchLesson').value;

//     var contentType = "playlist";
//     var searchQuery = "";

//     if (searchCode == "") {
//         showWarning("الرجاء إدخال رمز المادة.");
//         clearResults()
//         return;
//     }
//     if (searchCourse == "") {
//         showWarning("الرجاء إدخال اسم المادة.");
//         clearResults()
//         return;
//     }

//     if (searchLesson != "") {
//         if (isArabic(searchLesson) && label.textContent === 'Eng') {
//             showWarning("الرجاء إدخال اسم الدرس باللغة الإنجليزية.");
//             clearResults()
//             return;
//         } else if (!isArabic(searchLesson) && label.textContent === 'عربي') {
//             showWarning("الرجاء إدخال اسم الدرس باللغة العربية.");
//             clearResults()
//             return;
//         }
//         contentType = "video";
//     }

//     hideWarning()

//     // Handle translation for course and lesson separately
//     translateIfNeeded(searchCourse, translatedCourse => {
//         if (searchLesson) {
//             translateIfNeeded(searchLesson, translatedLesson => {
//                 searchQuery = translatedCourse + " " + translatedLesson;
//                 executeSearch(searchQuery, contentType);
//             });
//         } else {
//             searchQuery = translatedCourse;
//             executeSearch(searchQuery, contentType);
//         }
//     });
// }

// function translateIfNeeded(text, callback) {
//     if ((label.textContent === 'Eng' && isArabic(text)) || (label.textContent === 'عربي' && !isArabic(text))) {
//         const targetLanguage = label.textContent === 'Eng' ? 'en' : 'ar';
//         translateText(text, targetLanguage, translatedText => {
//             callback(translatedText);
//         });
//     } else {
//         callback(text);
//     }
// }

// function executeSearch(query, contentType) {
//     // This is where you execute your search using the query
//     // alert("Searching with query: " + query);
//     fetchYouTubeData(query, contentType);
// }


// function fetchYouTubeData(query, contentType) {
//     fetch(`https://www.googleapis.com/youtube/v3/search?key=${API_KEY}&type=${contentType}&part=snippet&maxResults=10&q=${query}`)
//         .then(response => response.json())
//         .then(data => {
//             displayResults(data.items, contentType);
//         })
//         .catch(error => {
//             console.error('Error fetching data:', error);
//         });
// }


// function formatDate(isoDateString) {
//     const date = new Date(isoDateString);
//     const day = date.toLocaleString('default', { day: '2-digit' })
//     const month = date.toLocaleString('default', { month: '2-digit' }).toLowerCase();
//     const year = date.getFullYear();
//     return `${day}-${month}-${year}`;
// }


// function displayResults(items, type) {
//     const resultsDiv = document.getElementById('results');
//     clearResults();

//     if (items && Array.isArray(items)) {
//         items.forEach(item => {
//             let id, linkURL, thumbnailURL;

//             const title = item.snippet.title;
//             const channelTitle = item.snippet.channelTitle;
//             const publishTime = formatDate(item.snippet.publishTime);
//             thumbnailURL = item.snippet.thumbnails.medium.url;

//             if (type === 'playlist') {
//                 id = item.id.playlistId; // There's a typo here; should be `item.id.playlistId` not `item.id.videoId`
//                 linkURL = `https://www.youtube.com/playlist?list=${id}`;
//             } else if (type === 'video') {
//                 id = item.id.videoId;
//                 linkURL = `https://www.youtube.com/watch?v=${id}`;
//             }

//             resultsDiv.innerHTML += `
//                 <div class="card">
//                     <img src="${thumbnailURL}" alt="${title} thumbnail" class="thumbnail">
//                     <h3>${title}</h3>
//                     <p>Channel: ${channelTitle}</p>
//                     <p>Published: ${publishTime}</p>
//                     <a href="${linkURL}" target="_blank">View ${type.charAt(0).toUpperCase() + type.slice(1)}</a>
//                 </div>
//             `;
//         });
//     } else {
//         // Handle the case where `items` is not defined or is not an array
//         showWarning("No results found.");
//     }
// }

// function showWarning(message) {
//     const warningDiv = document.getElementById('warning');
//     warningDiv.innerHTML = `
//         ${message}
//         <i class="material-icons">warning</i> 
//     `; // Set the warning message
//     warningDiv.style.display = 'block'; // Display the warning
// }

// function hideWarning() {
//     const warningDiv = document.getElementById('warning');
//     warningDiv.style.display = 'none'; // Hide the warning
// }
// let search = document.getElementById("search");
// search.addEventListener("click", ()=>{
//     searchYouTube()
// }
//