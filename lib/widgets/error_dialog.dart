import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String text;
  final String buttonLabel;

  const ErrorDialog({
    Key? key,
    this.title = 'Error',
    this.text = "Invalid request",
    this.buttonLabel = "OK",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        ElevatedButton(
          child: Text(buttonLabel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String text;

  const SuccessDialog({Key? key, this.text = "Request was successful"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Success"),
      content: Text(text),
      actions: [
        ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
