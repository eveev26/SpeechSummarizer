import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  final String summary;
  SummaryScreen({super.key, required this.summary});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(widget.summary));
  }
}
