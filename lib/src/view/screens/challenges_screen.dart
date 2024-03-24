import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/result.dart';
import 'package:challengify_app/src/view/screens/challenge_screen.dart';
import 'package:challengify_app/src/view/screens/join_challenge_screen.dart';
import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:challengify_app/src/view/widgets/result_difference.dart';
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

  late Future<List<Challenge>> _challengesFuture;

  @override
  void initState() {
    super.initState();

    _challengesFuture = _challengeInteractor.getUserChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: _challengesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return ChallengesColumn(
                      challenges: snapshot.data as List<Challenge>);
                }
              }),
        ),
        FullWidhtButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JoinChallengeScreen(),
                ),
              ).then((value) => setState(() {
                    _challengesFuture =
                        _challengeInteractor.getUserChallenges();
                  }));
            },
            text: "Join Challenge")
      ],
    );
  }
}

class ChallengesColumn extends StatefulWidget {
  final List<Challenge> challenges;
  const ChallengesColumn({super.key, required this.challenges});

  @override
  State<ChallengesColumn> createState() => _ChallengesColumnState();
}

class _ChallengesColumnState extends State<ChallengesColumn> {
  late Future<List<Result?>> _lastResultsFuture;

  final ChallengeInteractor _challengeInteractor =
      ChallengeInteractor(baseUrl: 'http://10.0.2.2:8080');

  @override
  void initState() {
    super.initState();

    _lastResultsFuture = Future.wait(widget.challenges
        .map((challenge) =>
            _challengeInteractor.getLastUserResult(challenge.challengeId))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.challenges.length,
      itemBuilder: (context, index) {
        DateTime lastResultTimestamp = widget.challenges[index].startDate;
        return Card(
            child: ListTile(
          title: Text(widget.challenges[index].name),
          subtitle: Text(widget.challenges[index].description),
          trailing: FutureBuilder(
              future: _lastResultsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError || snapshot.data == null) {
                  return TimeDifferenceWidget(
                      result: widget.challenges[index].startDate,
                      periodicity: widget.challenges[index].periodicity);
                } else {
                  Result? result = snapshot.data![index];
                  if (result != null) {
                    lastResultTimestamp = result.timestamp;
                  }
                  return TimeDifferenceWidget(
                      result: lastResultTimestamp,
                      periodicity: widget.challenges[index].periodicity);
                }
              }),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChallengeScreen(
                  challenge: widget.challenges[index],
                  lastResultTimestamp: lastResultTimestamp,
                ),
              ),
            ).then((value) => setState(() {
                  _lastResultsFuture = Future.wait(widget.challenges
                      .map((challenge) => _challengeInteractor
                          .getLastUserResult(challenge.challengeId))
                      .toList());
                }));
          },
        ));
      },
    );
  }
}
