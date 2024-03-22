import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/result.dart';
import 'package:challengify_app/src/view/screens/result_creating_screen.dart';
import 'package:challengify_app/src/view/screens/result_screen.dart';
import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:challengify_app/src/web_interactors/user_interactor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChallengeScreen extends StatelessWidget {
  final Challenge challenge;
  final List<Result> results;
  final UserInteractor _userInteractor =
      UserInteractor(baseUrl: 'http://10.0.2.2:8080');

  ChallengeScreen({super.key, required this.challenge, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(challenge.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${challenge.description}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Timestamp: ${challenge.startDate.toString().split(' ')[0]}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Results', style: TextStyle(fontSize: 24)),

            // Displaying results if the challenge.result is not null
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    for (Result result in results) // Displaying all results
                      SizedBox(
                        height: 220,
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    future:
                                        _userInteractor.getUser(result.userId),
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                          result: result,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('View Result'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ])),
            ),

            FullWidhtButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateResultScreen(
                        challengeId: challenge.challengeId,
                      ),
                    ),
                  );
                },
                text: "Add Result")
          ],
        ),
      ),
    );
  }
}
