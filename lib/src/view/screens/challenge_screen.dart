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

  ChallengeScreen(
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
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Till next result:', style: TextStyle(fontSize: 18)),
                TimeDifferenceWidget(
                  result: widget.lastResultTimestamp,
                  periodicity: widget.challenge.periodicity,
                  fontSize: 18,
                ),
              ],
            ),

            SizedBox(height: 20),
            _ClipBoardCode(joinCode: widget.challenge.joinCode),
            SizedBox(height: 20),
            Text('Results', style: TextStyle(fontSize: 24)),

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
                          return CircularProgressIndicator(); // Show loading spinner while waiting for the future to complete
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
                                      margin: EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              result.name,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text(result.description),
                                            SizedBox(height: 8.0),
                                            Text(
                                                'Created at : ${result.timestamp.toLocal().toString()[0]}'), // Formatting timestamp
                                            SizedBox(height: 8.0),
                                            FutureBuilder(
                                                future: _userInteractor
                                                    .getUser(result.userId),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                        'User: ${snapshot.data?.name ?? 'Unknown'}');
                                                  } else {
                                                    return Text('Unknown');
                                                  }
                                                }), // Displaying user's name, 'Unknown' if null
                                            SizedBox(height: 8.0),
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
                                              child: Text('View Result',
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

  _ClipBoardCode({required this.joinCode});

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
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  'Join Code: $joinCode',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.content_copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: joinCode)).then((result) {
                  final snackBar = SnackBar(
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
