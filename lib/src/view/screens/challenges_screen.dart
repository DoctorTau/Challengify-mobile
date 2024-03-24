import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/result.dart';
import 'package:challengify_app/src/view/screens/challenge_screen.dart';
import 'package:challengify_app/src/web_interactors/challenge_interactor.dart';
import 'package:flutter/material.dart';

class ChallengesScreen extends StatefulWidget {
  final List<Challenge> challenges;

  const ChallengesScreen({super.key, required this.challenges});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  final ChallengeInteractor _challengeInteractor =
      ChallengeInteractor(baseUrl: 'http://10.0.2.2:8080');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.challenges.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          title: Text(widget.challenges[index].name),
          subtitle: Text(widget.challenges[index].description),
          trailing: FutureBuilder(
              future: _challengeInteractor
                  .getLastUserResult(widget.challenges[index].challengeId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Text('No results yet');
                } else {
                  Result result = snapshot.data as Result;
                  return Text(
                      result.timestamp.toLocal().toString().split(' ')[0]);
                }
              }),
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
        ));
      },
    );
  }
}
