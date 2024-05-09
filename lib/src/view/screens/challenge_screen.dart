import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/result.dart';
import 'package:challengify_app/src/view/screens/result_creating_screen.dart';
import 'package:challengify_app/src/view/screens/result_screen.dart';
import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:challengify_app/src/view/widgets/result_difference.dart';
import 'package:challengify_app/src/web_interactors/challenge_interactor.dart';
import 'package:challengify_app/src/web_interactors/user_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChallengeScreen extends StatefulWidget {
  final Challenge challenge;
  final DateTime lastResultTimestamp;

  const ChallengeScreen(
      {super.key, required this.challenge, required this.lastResultTimestamp});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final UserInteractor _userInteractor =
      UserInteractor(baseUrl: dotenv.env['BASEURL']!);

  final ChallengeInteractor _challengeInteractor =
      ChallengeInteractor(baseUrl: dotenv.env['BASEURL']!);

  late Future<List<Result>> resultsFuture;

  @override
  void initState() {
    super.initState();
    resultsFuture =
        _challengeInteractor.getChallengeResults(widget.challenge.challengeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.challenge.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${widget.challenge.description}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Till next result:', style: TextStyle(fontSize: 18)),
                TimeDifferenceWidget(
                  result: widget.lastResultTimestamp,
                  periodicity: widget.challenge.periodicity,
                  fontSize: 18,
                ),
              ],
            ),

            const SizedBox(height: 20),
            _ClipBoardCode(joinCode: widget.challenge.joinCode),
            const SizedBox(height: 20),
            const Text('Results', style: TextStyle(fontSize: 24)),

            // Displaying results if the challenge.result is not null
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    FutureBuilder<List<Result>>(
                      future: resultsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show loading spinner while waiting for the future to complete
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // Show error message if the future completes with an error
                        } else {
                          List<Result> results = snapshot
                              .data!; // The future has completed successfully. `snapshot.data` contains the list of `Result` objects.

                          results = results.reversed.toList();
                          return Column(
                            children: results
                                .map(
                                  (result) => SizedBox(
                                    height: 220,
                                    width: double.infinity,
                                    child: Card(
                                      margin: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              result.name,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(result.description),
                                            const SizedBox(height: 8.0),
                                            Text(
                                                'Created at : ${result.timestamp.toLocal().toString().split(" ")[0]}'), // Formatting timestamp
                                            const SizedBox(height: 8.0),
                                            FutureBuilder(
                                                future: _userInteractor
                                                    .getUser(result.userId),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                        'User: ${snapshot.data?.name ?? 'Unknown'}');
                                                  } else {
                                                    return const Text('Unknown');
                                                  }
                                                }), // Displaying user's name, 'Unknown' if null
                                            const SizedBox(height: 8.0),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.blue),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResultScreen(
                                                      result: result,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text('View Result',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        }
                      },
                    )
                  ])),
            ),

            FullWidhtButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateResultScreen(
                        challengeId: widget.challenge.challengeId,
                      ),
                    ),
                  ).then(
                    (value) => setState(() {
                      resultsFuture = _challengeInteractor
                          .getChallengeResults(widget.challenge.challengeId);
                    }),
                  );
                },
                text: "Add Result")
          ],
        ),
      ),
    );
  }
}

class _ClipBoardCode extends StatelessWidget {
  final String joinCode;

  const _ClipBoardCode({required this.joinCode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Clipboard.setData(ClipboardData(text: joinCode)).then((result) {
            const snackBar = SnackBar(
              content: Text('Copied to Clipboard'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        },
        child: Row(
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  'Join Code: $joinCode',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.content_copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: joinCode)).then((result) {
                  const snackBar = SnackBar(
                    content: Text('Copied to Clipboard'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
            ),
          ],
        ));
  }
}
