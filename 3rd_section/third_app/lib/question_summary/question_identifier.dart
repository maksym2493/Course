import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier(this.isAnswerCorrect, this.questionIndex,
      {super.key});

  final String questionIndex;
  final bool isAnswerCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isAnswerCorrect
            ? const Color.fromARGB(255, 114, 179, 161)
            : const Color.fromARGB(255, 220, 108, 108),
      ),
      child: Text(
        questionIndex,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
