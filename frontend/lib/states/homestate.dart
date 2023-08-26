import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:dio/dio.dart';

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
                Text(trimLocation(fileLocation)),
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
                        onPressed: () {
                          mediaConvert(fileLocation).then((value) {
                            if (value != null) {
                              setState(() {
                                flaclocation = value;
                              });
                            }
                          }).whenComplete(() {
                            gbucketUpload(flaclocation);
                          });
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

Future<String?> uploadFile() async {
  String? fileLocation = '';
  FilePickerResult? tempLocation = await FilePicker.platform.pickFiles();
  if (tempLocation != null) {
    fileLocation = tempLocation.files.single.path;
  } else {}
  return fileLocation;
}

String trimLocation(String longString) {
  return longString.substring(longString.lastIndexOf('/') + 1);
}

Future<String?> mediaConvert(String fileLocation) async {
  String fileFlac =
      '${fileLocation.substring(0, fileLocation.lastIndexOf('.') + 1)}flac';
  FFmpegKit.execute('-i $fileLocation -acodec flac $fileFlac')
      .then((session) async {
    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      return fileFlac;
    }
  });
  return null;
}

gbucketUpload(String flacLocation) async {}
