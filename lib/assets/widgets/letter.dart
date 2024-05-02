import 'package:flutter/material.dart';

Widget hiddenLetter(String character, bool hidden) {
  bool isSpace = character == ' ';

  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(237, 148, 85, 1),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Center(
        child: Text(
          isSpace ? ' ' : character,
          style: TextStyle(
            color: hidden ? Colors.transparent : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
