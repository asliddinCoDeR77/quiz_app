import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/services/quiz_services.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<QuizFirebaseService>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.getScores(),
          builder: (context, snapshot) {
            // Check if snapshot has data
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No scores available"),
              );
            }

            final scores = snapshot.data!.docs;

            return ListView.builder(
              itemCount: scores.length,
              itemBuilder: (context, index) {
                final scoreData = scores[index].data() as Map<String, dynamic>;
                return ListTile(
                  leading: Text('#${index + 1}'),
                  title: Text(scoreData['username'] ?? 'Unknown'),
                  trailing: Text(scoreData['score'].toString()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
