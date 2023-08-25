import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<HomeState> createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> {
  String file_location = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FilledButton.tonal(
                      onPressed: () {
                        upload_file().then((value) => file_location);
                        print(file_location);
                      },
                      child: const Text('Upload')),
                  const SizedBox(
                    width: 20,
                  ),
                  FilledButton(onPressed: upload_file, child: Text('Start')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String?> upload_file() async {
  String? fileLocation = '';
  FilePickerResult? tempLocation = await FilePicker.platform.pickFiles();
  if (tempLocation != null) {
    fileLocation = tempLocation.files.single.path;
  } else {}
  print('bruh: $fileLocation');
  return fileLocation;
}
