import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<HomeState> createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> {
  String fileLocation = '';
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
                Text(trim(fileLocation)),
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
                          apiStart();
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

String trim(String longString) {
  return longString.substring(longString.lastIndexOf('/') + 1);
}

apiStart() async {}
