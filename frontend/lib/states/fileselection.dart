import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speechsummarizer/components/uploadcard.dart';
import 'package:speechsummarizer/networkcalls.dart';
import 'package:speechsummarizer/states/textprocess.dart';

class FileSelection extends StatefulWidget {
  const FileSelection({super.key});

  @override
  State<FileSelection> createState() => _FileSelectionState();
}

class _FileSelectionState extends State<FileSelection> {
  String filelocation = '';
  bool _fileSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 40, 25, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _fileSelected && filelocation != ''
                  ? UploadCard(
                      filename: trimLocation(filelocation),
                      filesize: File(filelocation).lengthSync() / 1000,
                    )
                  : Container(),
              const Spacer(),
              SizedBox(
                height: 65,
                width: MediaQuery.of(context).size.width,
                child: FilledButton.tonal(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {
                    uploadFile().then((value) {
                      setState(() {
                        filelocation = value!;
                        _fileSelected = true;
                      });
                    });
                  },
                  child: const Text(
                    'Choose a file',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
                  onPressed: _fileSelected && filelocation != ''
                      ? () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TextProcess(
                                        filelocation: filelocation,
                                      )),
                              (Route<dynamic> route) => false);
                        }
                      : null,
                  child: const Text(
                    'Begin',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
