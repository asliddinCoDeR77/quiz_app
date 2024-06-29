import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/services/quiz_services.dart';

class Productcontroller extends ChangeNotifier {
  final firebasecontroller = QuizFirebaseService();
  Stream<QuerySnapshot> get list {
    return firebasecontroller.getProduct();
  }
}
