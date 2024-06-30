import 'package:flutter/material.dart';
import 'package:quiz_app/services/quiz_services.dart';
import 'package:quiz_app/model/quiz.dart';

class EditQuestionScreen extends StatefulWidget {
  final Product? question;

  EditQuestionScreen({super.key, this.question});

  @override
  _EditQuestionScreenState createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController1;
  late TextEditingController _answerController2;
  late TextEditingController _answerController3;
  late TextEditingController _answerController4;
  late TextEditingController _correctAnswerController;
  final QuizFirebaseService _quizService = QuizFirebaseService();

  @override
  void initState() {
    super.initState();
    _questionController =
        TextEditingController(text: widget.question?.question ?? '');
    _answerController1 =
        TextEditingController(text: widget.question?.answers[0] ?? '');
    _answerController2 =
        TextEditingController(text: widget.question?.answers[1] ?? '');
    _answerController3 =
        TextEditingController(text: widget.question?.answers[2] ?? '');
    _answerController4 =
        TextEditingController(text: widget.question?.answers[3] ?? '');
    _correctAnswerController =
        TextEditingController(text: widget.question?.correct.toString() ?? '');
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController1.dispose();
    _answerController2.dispose();
    _answerController3.dispose();
    _answerController4.dispose();
    _correctAnswerController.dispose();
    super.dispose();
  }

  void _saveQuestion() {
    if (_formKey.currentState!.validate()) {
      final question = _questionController.text;
      final answers = [
        _answerController1.text,
        _answerController2.text,
        _answerController3.text,
        _answerController4.text,
      ];
      final correct = int.parse(_correctAnswerController.text);

      if (widget.question == null) {
        _quizService.addQuestion(
          Product(
            id: '',
            question: question,
            answers: answers,
            correct: correct,
          ),
        );
      } else {
        _quizService.updateQuestion(
          Product(
            id: widget.question!.id,
            question: question,
            answers: answers,
            correct: correct,
          ),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.question == null ? 'Add Question' : 'Edit Question'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveQuestion,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _answerController1,
                decoration: InputDecoration(labelText: 'Answer 1'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter answer 1';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _answerController2,
                decoration: InputDecoration(labelText: 'Answer 2'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter answer 2';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _answerController3,
                decoration: InputDecoration(labelText: 'Answer 3'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter answer 3';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _answerController4,
                decoration: InputDecoration(labelText: 'Answer 4'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter answer 4';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _correctAnswerController,
                decoration:
                    InputDecoration(labelText: 'Correct Answer (Index 0-3)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the correct answer index';
                  }
                  final intValue = int.tryParse(value);
                  if (intValue == null || intValue < 0 || intValue > 3) {
                    return 'Please enter a valid index (0-3)';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
