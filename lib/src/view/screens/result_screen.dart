import 'package:challengify_app/src/models/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ResultScreen extends StatelessWidget {
  final Result result;
  final String baseUrl = dotenv.env['BASEURL']!;

  ResultScreen({Key? key, required this.result}) : super(key: key) {
    print(result.mediaPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Name: ${result.name}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text('Description: ${result.description}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Text(
                  'Timestamp: ${result.timestamp.toLocal().toString().split(" ")[0]}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              // Image from url
              if (result.mediaPath.isNotEmpty)
                Image.network(
                    "$baseUrl/api/challenge/media/${result.mediaPath}"),
            ],
          ),
        ),
      ),
    );
  }
}
