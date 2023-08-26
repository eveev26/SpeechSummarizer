import 'package:flutter/material.dart';
import 'package:speechsummarizer/networkcalls.dart';

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
      body: SafeArea(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FilledButton.tonal(
                        onPressed: () {
                          uploadFile().then((value) {
                            setState(() {
                              fileLocation = value!;
                            });
                          });
                        },
                        child: const Text('Upload')),
                    const SizedBox(
                      width: 20,
                    ),
                    FilledButton(
                        onPressed: () async {
                          String? value = await mediaConvert(fileLocation);

                          if (value != null) {
                            setState(() {
                              flaclocation = value;
                            });
                          }
                          gbucketUpload(flaclocation);
                        },
                        child: const Text('Start')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String trimLocation(String longString) {
  return longString.substring(longString.lastIndexOf('/') + 1);
}
