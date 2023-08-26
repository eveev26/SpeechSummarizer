import 'package:flutter/material.dart';
import 'package:speechsummarizer/networkcalls.dart';
import 'dart:ui' as ui;

import 'package:speechsummarizer/states/fileselection.dart';

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<HomeState> createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> {
  String fileLocation = '';
  String flaclocation = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        // size: const Size(300, 200),
        painter: WavePainter(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'SpeechSummarizer',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'The easiest way to simplify your meetings and other forms of media',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 45,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                    ),
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust this value for sharper corners
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FileSelection()));
                        },
                        child: const Text(
                          'Start',
                          style: TextStyle(fontSize: 23),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 15;

    Offset center = Offset(size.width / 20, size.height / 5);

    canvas.drawCircle(center, 50, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

String trimLocation(String longString) {
  return longString.substring(longString.lastIndexOf('/') + 1);
}
