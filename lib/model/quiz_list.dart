import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz.dart';
import 'package:quiz_app/screen/quiz_screen.dart';

class QuizListScreen extends StatelessWidget {
  final List<Quiz> quizzes;

  QuizListScreen({required this.quizzes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Quizzes'),
      ),
      body: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(quizzes[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(quiz: quizzes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
