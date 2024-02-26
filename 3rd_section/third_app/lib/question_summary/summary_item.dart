import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:third_app/question_summary/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.data, {super.key});

  final Map<String, Object> data;

  @override
  Widget build(BuildContext context) {
    final isAnswerCorrect = data['user_answer'] == data['correct_answer'];
    final questionIndex = ((data['question_index'] as int) + 1).toString();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIdentifier(
          isAnswerCorrect,
          questionIndex,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['question'] as String,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data['user_answer'] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 220, 108, 108),
                ),
              ),
              Text(
                data['correct_answer'] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 114, 179, 161),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ],
    );
  }
}
