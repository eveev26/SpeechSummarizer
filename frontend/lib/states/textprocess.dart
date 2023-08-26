import 'package:flutter/material.dart';
import 'package:speechsummarizer/networkcalls.dart';

class TextProcess extends StatefulWidget {
  final String filelocation;
  const TextProcess({super.key, required this.filelocation});

  @override
  State<TextProcess> createState() => _TextProcessState();
}

class _TextProcessState extends State<TextProcess>
    with TickerProviderStateMixin {
  late AnimationController controller;
  double progress = 0;
  String? flaclocation;
  bool flacconversion = false;
  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    mediaConvert(widget.filelocation).then((value) {
      if (value != null) {
        setState(() {
          flaclocation = value;
          controller.animateTo(0.25,
              duration: const Duration(seconds: 1),
              curve: Curves.fastEaseInToSlowEaseOut);
        });
        print(flaclocation);
        gbucketUpload(flaclocation!).then((value) {
          if (value) {
            setState(() {
              controller.animateTo(0.5,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastEaseInToSlowEaseOut);
            });
          }
        });
      } else {
        setState(() {
          flacconversion = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          LinearProgressIndicator(
            value: controller.value,
          ),
        ],
      )),
    );
  }
}
