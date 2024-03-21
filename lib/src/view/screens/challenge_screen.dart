import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/result.dart';
import 'package:challengify_app/src/view/screens/result_screen.dart';
import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChallengeScreen extends StatelessWidget {
  final Challenge challenge;
  const ChallengeScreen({super.key, required this.challenge});

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
            SingleChildScrollView(
                child: Column(children: [
              if (challenge.results != null)
                ...challenge.results!.map((result) {
                  return _ResultsList(result: result);
                }).toList(),
            ])),

            Spacer(),
            FullWidhtButton(onPressed: () {}, text: "Add Result")
          ],
        ),
      ),
    );
  }
}

class _ResultsList extends StatelessWidget {
  final Result result;
  const _ResultsList({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Text(
                'User: ${result.user?.name ?? 'Unknown'}'), // Displaying user's name, 'Unknown' if null
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
    );
  }
}
