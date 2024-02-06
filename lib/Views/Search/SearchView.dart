import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafeq_app/Views/Search/ContentCard.dart';
import 'package:rafeq_app/Views/Search/SearchResultModel.dart';
import 'package:rafeq_app/Views/Settings/DarkThemeProvider.dart';
import '../../generated/l10n.dart';
import 'package:rafeq_app/Views/Settings/LanguageProvider.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    var darkThemeProvider = Provider.of<DarkThemeProvider>(context);
    var searchResultModel = Provider.of<SearchResultModel>(context);
    final searchCodeController =
        TextEditingController(text: searchResultModel.searchCode);
    final searchCourseController =
        TextEditingController(text: searchResultModel.searchCourse);
    final searchLessonController =
        TextEditingController(text: searchResultModel.searchLesson);

    var languageProvider = Provider.of<LanguageProvider>(context);
    var localizations = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: darkThemeProvider.isDarkModeEnabled
                    ? Colors.black
                    : Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 4,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          searchResultModel.toggleTextContext();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            searchResultModel.textContent,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: darkThemeProvider.isDarkModeEnabled
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: searchCourseController,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: darkThemeProvider.isDarkModeEnabled
                                ? Colors.grey
                                : Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: languageProvider
                                .translate("searchMaterialName"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          searchResultModel.changeSearchQuery(
                            newSearchCode: searchCodeController.text,
                            newSearchCourse: searchCourseController.text,
                            newSearchLesson: searchLessonController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1C96F9),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(languageProvider.translate("search")),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: searchLessonController,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: darkThemeProvider.isDarkModeEnabled
                                ? Colors.grey
                                : Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                languageProvider.translate("searchButton"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (searchResultModel.isShowingWarning) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          searchResultModel.warningMessage,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.warning,
                            size: 12, color: Colors.red.withOpacity(0.8)),
                      ],
                    ),
                  ]
                ],
              ),
            ),
            Expanded(
              child: SearchResultWidget(searchResultModel: searchResultModel),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
    required this.searchResultModel,
  });

  final SearchResultModel searchResultModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResultModel.searchResult.length,
      itemBuilder: (context, index) =>
          ContentCard(video: searchResultModel.searchResult[index]),
    );
  }
}
