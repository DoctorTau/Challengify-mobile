import 'package:flutter/material.dart';

class FullWidhtButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const FullWidhtButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(text),
          )),
    );
  }
}
