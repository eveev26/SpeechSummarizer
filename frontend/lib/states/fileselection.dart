import 'package:flutter/material.dart';
import 'package:speechsummarizer/networkcalls.dart';
import 'package:speechsummarizer/color_schemes.g.dart';

class FileSelection extends StatefulWidget {
  const FileSelection({super.key});

  @override
  State<FileSelection> createState() => _FileSelectionState();
}

class _FileSelectionState extends State<FileSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? darkColorScheme.primaryContainer
                        : lightColorScheme.primaryContainer,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
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
