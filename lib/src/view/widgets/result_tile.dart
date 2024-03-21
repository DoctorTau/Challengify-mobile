import 'package:challengify_app/src/models/result.dart';
import 'package:flutter/material.dart';

class ResultTile extends StatelessWidget {
  final Result result;

  ResultTile({required this.result});

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
          ],
        ),
      ),
    );
  }
}
