class HangmanGame {
  static List<String> selectedLetter = [];
  static int tries = 0;

  static void reset() {
    selectedLetter.clear();
    tries = 0;
  }

  static bool isLetterSelected(String letter) {
    return selectedLetter.contains(letter);
  }

  static bool isWordGuessed(String word) {
    for (int i = 0; i < word.length; i++) {
      String letter = word[i];
      if (letter != ' ' && !selectedLetter.contains(letter)) {
        return false;
      }
    }
    return true;
  }
}
