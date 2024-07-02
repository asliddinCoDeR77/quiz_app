import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/auth/reset_password.dart';
import 'package:quiz_app/screen/quiz_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Homepage(),
      ));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login: $e')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen()),
                );
              },
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
