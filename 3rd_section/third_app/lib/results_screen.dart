import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:third_app/data/questions.dart';
import 'package:third_app/question_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(this.chosenAnswers, this.onRestart, {super.key});

  final List<String> chosenAnswers;
  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }

    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;

    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
            ),
            const SizedBox(height: 30),
            QuestionSummary(summaryData),
            const SizedBox(height: 30),
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              onPressed: onRestart,
              label: const Text(
                'Restart Quiz!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
