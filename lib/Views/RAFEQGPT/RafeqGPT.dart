import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rafeq_app/Views/Settings/DarkThemeProvider.dart';
import 'package:rafeq_app/Views/Settings/LanguageProvider.dart';

class RafeqGPT extends StatefulWidget {
  @override
  _RafeqGPTState createState() => _RafeqGPTState();
}

class _RafeqGPTState extends State<RafeqGPT> {
  final TextEditingController _textController = TextEditingController();
  List<String> _messages = ["RafeqGPT: " + "hi user ", "You: " + "hi  ai"];

  void _sendMessage(String text, LanguageProvider languageProvider) async {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add("You: $text");
      });

      _textController.clear();
      var response = await http.post(
        Uri.parse(
            'https://api.openai.com/v1/engines/gpt-3.5-turbo/completions'), // Adjusted endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              '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' // Replace with your API key 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
        },
        body: jsonEncode({
          'prompt': text,
          'max_tokens': 150,
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _messages.add("RafeqGPT: " + data['choices'][0]['text']);
        });
      } else {
        setState(() {
          _messages.add("RafeqGPT: Error getting response");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkThemeProvider = Provider.of<DarkThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.translate('RafeeqChatGPT')),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(5),
                // if contains RafeqGPT, margin right 10 else margin left 10
                margin: _messages[index].contains("RafeqGPT")
                    ? EdgeInsets.only(left: 10, right: 40, bottom: 20)
                    : EdgeInsets.only(left: 40, right: 10, bottom: 20),
                decoration: BoxDecoration(
                  color: _messages[index].contains("RafeqGPT")
                      ? const Color.fromARGB(255, 49, 154, 241)
                      : (darkThemeProvider.isDarkModeEnabled
                          ? Colors.grey[
                              300] // Change to the desired color for dark mode
                          : Colors.grey[300]),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: _messages[index].contains("RafeqGPT")
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Text(languageProvider.translate(_messages[index])),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: (text) => _sendMessage(text, languageProvider),
                    decoration: InputDecoration(
                      labelText: languageProvider.translate('Send a message'),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () =>
                      _sendMessage(_textController.text, languageProvider),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
