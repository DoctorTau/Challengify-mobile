import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/view/screens/challenge_screen.dart';
import 'package:flutter/material.dart';

class ChallengesScreen extends StatefulWidget {
  final List<Challenge> challenges;

  const ChallengesScreen({super.key, required this.challenges});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
      ),
      body: ListView.builder(
        itemCount: widget.challenges.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(widget.challenges[index].name),
              subtitle: Text(widget.challenges[index].description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChallengeScreen(
                      challenge: widget.challenges[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
