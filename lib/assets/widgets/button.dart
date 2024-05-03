import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String letter;
  final Function(String) setLetter;
  final bool press;
  final bool isCorrect;

  const Button({
    Key? key,
    required this.letter,
    required this.setLetter,
    required this.press,
    required this.isCorrect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color.fromRGBO(255, 187, 112, 1);
    if (press && !isCorrect) {
      buttonColor = Colors.red;
    } else if (press && isCorrect) {
      buttonColor = Colors.green;
    }

    return Expanded(
      child: GestureDetector(
        onTap: press == false
            ? () {
                setLetter(letter);
              }
            : null,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 3.0, vertical: 6.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: buttonColor,
            ),
            child: Center(
              child: Text(
                letter,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
