import 'dart:async';
import 'package:flutter/material.dart';

class TimeDifferenceWidget extends StatefulWidget {
  final DateTime result;
  final int periodicity;
  final double fontSize;

  TimeDifferenceWidget(
      {Key? key, required this.result, required this.periodicity, this.fontSize = 14})
      : super(key: key);

  @override
  _TimeDifferenceWidgetState createState() => _TimeDifferenceWidgetState();
}

class _TimeDifferenceWidgetState extends State<TimeDifferenceWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer that ticks every second.
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        // This empty setState call tells the widget to rebuild every second,
        // updating the display with the latest time difference.
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the new DateTime after adding the periodicity in hours
    DateTime adjustedResult =
        widget.result.add(Duration(hours: widget.periodicity));
    // Get the current DateTime
    DateTime now = DateTime.now();
    // Calculate the difference
    Duration difference = adjustedResult.difference(now);

    String displayText;
    Color textColor = Colors.black; // Default text color for future times

    // Determine the display based on the time difference
    if (difference.isNegative) {
      // Time has passed, calculate missed time
      Duration missed = difference.abs();
      if (missed.inDays > 0) {
        displayText = 'Missed by ${missed.inDays} days';
      } else if (missed.inHours > 0) {
        displayText = 'Missed by ${missed.inHours} hours';
      } else {
        displayText = 'Missed by ${missed.inMinutes} minutes';
      }
      textColor = Colors.red; // Missed time is displayed in red
    } else {
      // Future time, determine display based on duration
      if (difference.inDays > 0) {
        displayText = '${difference.inDays} days left';
      } else if (difference.inHours > 0) {
        displayText = '${difference.inHours} hours left';
      } else {
        displayText = '${difference.inMinutes} minutes left';
        textColor = Colors.red; // Less than an hour left is displayed in red
      }
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        displayText,
        style: TextStyle(fontSize: widget.fontSize, color: textColor),
      ),
    );
  }
}
