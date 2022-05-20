import 'package:flutter/material.dart';

class IssueDetailPage extends StatelessWidget {
  const IssueDetailPage({Key? key, required this.issueId}) : super(key: key);
  final String issueId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('issue detail $issueId'),
      ),
    );
  }
}
