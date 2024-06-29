import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;

  QuizScreen({required this.quiz});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  void _answerQuestion(int selectedOptionIndex) {
    if (selectedOptionIndex ==
        widget.quiz.questions[_currentQuestionIndex].correctOptionIndex) {
      _score++;
    }

    setState(() {
      if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Quiz is completed
        _showScoreDialog();
      }
    });
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Completed'),
          content:
              Text('Your score is $_score/${widget.quiz.questions.length}'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = widget.quiz.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              currentQuestion.questionText,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < currentQuestion.options.length; i++)
              ElevatedButton(
                onPressed: () => _answerQuestion(i),
                child: Text(currentQuestion.options[i]),
              ),
          ],
        ),
      ),
    );
  }
}
