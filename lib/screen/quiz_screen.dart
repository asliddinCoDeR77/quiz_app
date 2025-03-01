import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quiz_app/admin_panel/admin.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/model/quiz.dart';
import 'package:quiz_app/screen/leabordsscreen.dart';
import 'package:quiz_app/services/quiz_services.dart';
import 'package:quiz_app/widgets/quiz_widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = 0;
  Map<int, int> selectedAnswers = {};
  int score = 0;

  final pagecontroller = PageController();

  void _nextQuestion() {
    pagecontroller.nextPage(
        duration: const Duration(seconds: 3), curve: Curves.easeIn);
  }

  void _incrementScore() {
    setState(() {
      score++;
    });

    // Get the current user ID
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userId = user.uid;
      // Update the score in Firestore
      final controller = context.read<QuizFirebaseService>();
      controller.updateScore(userId, score);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<Productcontroller>();
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.leaderboard),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LeaderboardScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: controller.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text("Mahsulotlar mavjud emas"),
              );
            }
            final products = snapshot.data!.docs;

            return products.isEmpty
                ? const Center(
                    child: Text("Mahsulotlar mavjud emas"),
                  )
                : Center(
                    child: PageView.builder(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: products.length,
                      controller: pagecontroller,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final product =
                            Product.fromJson(snapshot.data!.docs[index]);
                        final question = product.question;
                        final answers = product.answers;
                        int correctanswer = product.correct;

                        return Pageviewbuilder(
                            answers: answers,
                            question: question,
                            index: index,
                            correct: correctanswer,
                            nextquestion: _nextQuestion,
                            incrementScore:
                                _incrementScore); // Pass incrementScore function
                      },
                    ),
                  );
          },
        ),
      ),
      drawer: Drawer(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminPanel()),
            );
          },
          child: ListTile(
            title: Text('Admin Panel'),
          ),
        ),
      ),
    );
  }
}
