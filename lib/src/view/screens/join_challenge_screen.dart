import 'package:challengify_app/src/view/widgets/full_width_button.dart';
import 'package:challengify_app/src/web_interactors/challenge_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JoinChallengeScreen extends StatefulWidget {
  const JoinChallengeScreen({super.key});

  @override
  State<JoinChallengeScreen> createState() => _JoinChallengeScreenState();
}

class _JoinChallengeScreenState extends State<JoinChallengeScreen> {
  final ChallengeInteractor _challengeInteractor =
      ChallengeInteractor(baseUrl: dotenv.env['BASEURL']!);
  final _joinCodeController = TextEditingController();

  Future<void> _joinChallenge() async {
    try {
      await _challengeInteractor.joinChallenge(_joinCodeController.text);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to join challenge: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _joinCodeController,
              decoration: const InputDecoration(
                labelText: 'Join Code',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FullWidhtButton(
              onPressed: _joinChallenge,
              text: 'Join Challenge',
            ),
          ],
        ),
      ),
    );
  }
}
