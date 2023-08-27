import 'package:flutter/material.dart';
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
        painter: Painter(),
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
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  child: FilledButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
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
                    ),
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

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    var red = Paint()
      ..color = const Color(0xFFB2495B)
      ..strokeWidth = 15;
    var blue = Paint()
      ..color = const Color(0xFF49B2A1)
      ..strokeWidth = 15;
    var green = Paint()
      ..color = const Color(0xFF8FB249)
      ..strokeWidth = 15;
    Offset circleoffsets = Offset(size.width / 4, size.height / 5);
    Rect rect = Offset(size.width - size.width / 1.5, size.height / 30) &
        const Size(100, 100);
    final path = Path()
      ..moveTo(center.dx - 20, center.dy - 50) // Top point
      ..lineTo(center.dx - 70, center.dy + 50) // Bottom-left point
      ..lineTo(center.dx + 30, center.dy + 50) // Bottom-right point
      ..close();
    canvas.drawPath(path, blue);
    const rotationAngle = 45 * (3.141592653589793 / 180);
    canvas.drawCircle(circleoffsets, 50, red);
    //canvas.save();
    canvas.translate(rect.center.dx, rect.center.dy);
    canvas.rotate(rotationAngle);
    canvas.drawRect(rect, green);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

String trimLocation(String longString) {
  return longString.substring(longString.lastIndexOf('/') + 1);
}
