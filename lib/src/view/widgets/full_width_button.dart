import 'package:flutter/material.dart';

class FullWidhtButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const FullWidhtButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text(text,
                  style: const TextStyle(fontSize: 20, color: Colors.white)))),
    );
  }
}
