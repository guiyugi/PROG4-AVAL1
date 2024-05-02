import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String letter;
  final Function(String) setLetter;
  final bool press;
  final bool isCorrect; // Indica se a letra é correta

  const Button({
    Key? key,
    required this.letter,
    required this.setLetter,
    required this.press,
    required this.isCorrect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color.fromRGBO(255, 187, 112, 1); // Cor padrão
    if (press && !isCorrect) {
      buttonColor = Colors
          .red; // Se a letra for errada e pressionada, botão fica vermelho
    } else if (press && isCorrect) {
      buttonColor = Colors
          .green; // Se a letra for correta e pressionada, botão fica verde
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
              horizontal: 3.0,
              vertical:
                  6.0), // Adicionando um padding de 4.0 em todas as direções
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: buttonColor, // Aplicando a cor determinada
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
