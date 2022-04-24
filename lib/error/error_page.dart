import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, required this.exception}) : super(key: key);

  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(exception.toString()),
    ));
  }
}
