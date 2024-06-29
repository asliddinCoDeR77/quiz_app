import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz.dart';

class AdminPanel extends StatefulWidget {
  final List<Quiz> quizzes;

  AdminPanel({required this.quizzes});

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final TextEditingController _titleController = TextEditingController();

  void _addQuiz() {
    if (_titleController.text.isNotEmpty) {
      setState(() {
        widget.quizzes.add(Quiz(title: _titleController.text, questions: []));
      });
      _titleController.clear();
    }
  }

  void _deleteQuiz(int index) {
    setState(() {
      widget.quizzes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Quiz Title'),
            ),
          ),
          ElevatedButton(
            onPressed: _addQuiz,
            child: Text('Add Quiz'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.quizzes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.quizzes[index].title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteQuiz(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
