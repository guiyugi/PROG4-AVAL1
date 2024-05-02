import 'package:flutter/material.dart';
import 'package:hangman2/assets/data/words.dart';
import 'package:hangman2/assets/widgets/figure_stick.dart';
import 'package:hangman2/assets/widgets/keyboard.dart';
import 'package:hangman2/assets/widgets/letter.dart';
import 'package:hangman2/themes/app_colors.dart';
import 'package:hangman2/utils/hangman_game.dart';

class HangmanScreen extends StatefulWidget {
  const HangmanScreen({Key? key}) : super(key: key);

  @override
  State<HangmanScreen> createState() => _HangmanScreenState();
}

class _HangmanScreenState extends State<HangmanScreen> {
  List<String> words = [];
  List<String> hints = [];
  int currentWordIndex = 0;
  bool isWordGuessed = false;
  bool isHangmanComplete = false;
  bool showCongratulations = false;
  List<String> selectedLetters = [];

  @override
  void initState() {
    super.initState();
    _initializeWords();
  }

  void _initializeWords() {
    List<String> shuffledWords = HangmanWords.words.keys.toList()..shuffle();
    List<String> shuffledHints =
        shuffledWords.map((word) => HangmanWords.words[word]!).toList();

    setState(() {
      words = shuffledWords;
      hints = shuffledHints;
      selectedLetters.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentWord = words[currentWordIndex].toUpperCase();
    String currentWordHint = hints[currentWordIndex];
    bool showHint = HangmanGame.tries >= 4;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Jogo da Forca'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                figureStick(
                    HangmanGame.tries >= 0, 'lib/assets/images/hang.png'),
                figureStick(
                  HangmanGame.tries >= 1,
                  'lib/assets/images/head.png',
                ),
                figureStick(
                  HangmanGame.tries >= 2,
                  'lib/assets/images/body.png',
                ),
                figureStick(
                  HangmanGame.tries >= 3,
                  'lib/assets/images/l_leg.png',
                ),
                figureStick(
                  HangmanGame.tries >= 4,
                  'lib/assets/images/r_leg.png',
                ),
                figureStick(
                  HangmanGame.tries >= 5,
                  'lib/assets/images/l_arm.png',
                ),
                figureStick(
                  HangmanGame.tries >= 6,
                  'lib/assets/images/r_arm.png',
                ),
              ],
            ),
          ),
          Wrap(
            children: currentWord.split('').map<Widget>((character) {
              if (character == ' ') {
                return hiddenLetter(character, true);
              } else {
                return hiddenLetter(
                  character,
                  !selectedLetters.contains(character),
                );
              }
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              showHint ? 'Dica: $currentWordHint' : '',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: isWordGuessed
                ? Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor,
                        ),
                        onPressed: () {
                          if (currentWordIndex < words.length - 1) {
                            setState(() {
                              currentWordIndex++;
                              HangmanGame.reset();
                              isWordGuessed = false;
                              showCongratulations = false;
                              selectedLetters.clear();
                            });
                          } else {
                            setState(() {
                              currentWordIndex = 0;
                              _initializeWords();
                              HangmanGame.reset();
                              isWordGuessed = false;
                              showCongratulations = false;
                              selectedLetters.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Todas as palavras foram jogadas. O jogo vai reiniciar do zero.'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            currentWordIndex < words.length - 1
                                ? 'Próxima Palavra'
                                : 'Reiniciar Jogo',
                          ),
                        ),
                      ),
                      if (showCongratulations)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Parabéns! Você acertou :)',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  )
                : isHangmanComplete
                    ? Column(
                        children: [
                          const Text(
                            'Você perdeu!',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  currentWordIndex = 0;
                                  _initializeWords();
                                  HangmanGame.reset();
                                  isHangmanComplete = false;
                                  selectedLetters.clear();
                                });
                              },
                              child: const Text(
                                'Reiniciar Jogo',
                              ),
                            ),
                          ),
                        ],
                      )
                    : Keyboard(
                        setLetter: (String letter) {
                          setState(() {
                            if (!HangmanGame.selectedLetter.contains(letter)) {
                              HangmanGame.selectedLetter.add(letter);
                              selectedLetters.add(letter);

                              if (letter != ' ' &&
                                  !currentWord.contains(letter)) {
                                HangmanGame.tries++;

                                if (HangmanGame.tries >= 6) {
                                  isHangmanComplete = true;
                                }
                              } else {
                                isWordGuessed =
                                    HangmanGame.isWordGuessed(currentWord);
                                if (isWordGuessed) {
                                  showCongratulations = true;
                                }
                              }
                            }
                          });
                        },
                        chosenLetters: selectedLetters,
                        currentWord: currentWord,
                      ),
          ),
          const Text(
            'Antonio Guilherme',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ),
          const Text(
            'Milena Andrade',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
        ],
      ),
    );
  }
}
