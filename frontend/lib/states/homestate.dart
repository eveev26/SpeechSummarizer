import 'package:flutter/material.dart';
import 'package:speechsummarizer/networkcalls.dart';
import 'dart:ui' as ui;

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
        size: const Size(300, 200),
        painter: WavePainter(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Align(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'SpeechSummarizer',
                    style: TextStyle(fontSize: 35),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'File: ${trimLocation(fileLocation)}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton.tonal(
                        onPressed: () {
                          uploadFile().then((value) {
                            setState(() {
                              fileLocation = value!;
                            });
                          });
                        },
                        child: const Text('Upload')),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                        onPressed: () async {
                          if (fileLocation != '') {
                            String? value = await mediaConvert(fileLocation);

                            if (value != null) {
                              setState(() {
                                flaclocation = value;
                              });
                            }
                            gbucketUpload(flaclocation);
                          }
                        },
                        child: const Text('Start')),
                  ),
                ],
              ),
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
