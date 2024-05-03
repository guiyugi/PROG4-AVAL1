import 'package:flutter/material.dart';
import 'button.dart';

class Keyboard extends StatelessWidget {
  final Function(String) setLetter;
  final List<String> chosenLetters;
  final String currentWord;

  const Keyboard({
    Key? key,
    required this.setLetter,
    required this.chosenLetters,
    required this.currentWord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    int numButtonsPerRow = 7;

    return Column(
      children: [
        for (int i = 0; i < alphabet.length; i += numButtonsPerRow)
          Row(
            children: [
              for (int j = i;
                  j < i + numButtonsPerRow && j < alphabet.length;
                  j++)
                Button(
                  letter: alphabet[j],
                  setLetter: setLetter,
                  press: chosenLetters.contains(alphabet[j]),
                  isCorrect: currentWord.contains(alphabet[j]),
                ),
            ],
          ),
      ],
    );
  }
}
