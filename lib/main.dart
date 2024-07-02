import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/auth/login_screen.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/screen/leabordsscreen.dart';
import 'package:quiz_app/screen/quiz_screen.dart';
import 'package:quiz_app/services/quiz_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Productcontroller()),
        Provider(create: (_) => QuizFirebaseService()),
      ],
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            appBarTheme:
                const AppBarTheme(backgroundColor: Colors.deepPurpleAccent)),
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => Homepage(),
          '/login': (context) => LoginScreen(),
          '/leaderboard': (context) => LeaderboardScreen(),
        },
      ),
    );
  }
}
