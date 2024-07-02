import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/model/quiz.dart';

class QuizFirebaseService {
  final _quizController = FirebaseFirestore.instance.collection('products');
  final _scoresController = FirebaseFirestore.instance.collection('scores');

  Stream<QuerySnapshot> getProduct() async* {
    yield* _quizController.snapshots();
  }

  Future<void> addQuestion(Product product) async {
    await _quizController.add({
      'question': product.question,
      'answers': product.answers,
      'correct': product.correct,
    });
  }

  Future<void> updateQuestion(Product product) async {
    await _quizController.doc(product.id).update({
      'question': product.question,
      'answers': product.answers,
      'correct': product.correct,
    });
  }

  Future<void> deleteQuestion(String id) async {
    await _quizController.doc(id).delete();
  }

  Future<void> updateScore(String userId, int score) async {
    await _scoresController.doc(userId).set({
      'score': score,
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getScores() async* {
    yield* _scoresController.orderBy('score', descending: true).snapshots();
  }
}
