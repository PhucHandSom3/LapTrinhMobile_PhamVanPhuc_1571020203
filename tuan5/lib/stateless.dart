import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String inputSentence = "Học để thay đổi";

  int countWords(String sentence) {
    List<String> words = sentence.split(' ');
    return words.length;
  }

  @override
  Widget build(BuildContext context) {
    int wordCount = countWords(inputSentence);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Word Count App'),
        ),
        body: Center(
          child: Text(
            'Number of words: $wordCount',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
