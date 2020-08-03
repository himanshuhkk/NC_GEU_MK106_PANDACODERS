import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class HangmanWords {
  int wordCounter = 0;
  List<int> _usedNumbers = [];
  List<String> _words = [];
  List<String> _questions = [];

  Future readWords() async {
    String fileText = await rootBundle.loadString('assets/res/hangman_words.txt');
    var sentences = fileText.split('\n');
    sentences.forEach((element) {
      var split = element.split("\$");
      _words.add(split[0]);
      _questions.add(split[1]);
    });
  }

  void resetWords() {
    wordCounter = 0;
    _usedNumbers = [];
//    _words = [];
  }

  // ignore: missing_return
  Map<String, String> getWord() {
    wordCounter += 1;
    var rand = Random();
    int wordLength = _words.length;
    int randNumber = rand.nextInt(wordLength);
    bool notUnique = true;
    if (wordCounter - 1 == _words.length) {
      notUnique = false;
      return {
        "word": '',
        "question": '',
      };
    }
    while (notUnique) {
      if (!_usedNumbers.contains(randNumber)) {
        notUnique = false;
        _usedNumbers.add(randNumber);
        return {
          "word": _words[randNumber],
          "question": _questions[randNumber],
        };
      } else {
        randNumber = rand.nextInt(wordLength);
      }
    }
  }

  String getHiddenWord(int wordLength) {
    String hiddenWord = '';
    for (int i = 0; i < wordLength; i++) {
      hiddenWord += '_';
    }
    return hiddenWord;
  }
}
