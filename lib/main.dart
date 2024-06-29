import 'package:flutter/material.dart';
import 'package:quiz_app/adminpanel/admin.dart';
import 'package:quiz_app/model/quiz.dart';
import 'package:quiz_app/model/quiz_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Quiz> _quizzes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
        quizzes: _quizzes,
        onAddQuiz: (quiz) {
          setState(() {
            _quizzes.add(quiz);
          });
        },
        onDeleteQuiz: (index) {
          setState(() {
            _quizzes.removeAt(index);
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Quiz> quizzes;
  final Function(Quiz) onAddQuiz;
  final Function(int) onDeleteQuiz;

  HomeScreen({
    required this.quizzes,
    required this.onAddQuiz,
    required this.onDeleteQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminPanel(quizzes: quizzes),
                  ),
                );
              },
              child: Text('Admin Panel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizListScreen(quizzes: quizzes),
                  ),
                );
              },
              child: Text('Take a Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
