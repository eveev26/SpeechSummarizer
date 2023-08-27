import 'package:flutter/material.dart';
import 'package:speechsummarizer/networkcalls.dart';
import 'package:speechsummarizer/states/fileselection.dart';
import 'package:speechsummarizer/states/summaryscreen.dart';
import 'package:speechsummarizer/color_schemes.g.dart';

class TextProcess extends StatefulWidget {
  final String filelocation;
  const TextProcess({super.key, required this.filelocation});

  @override
  State<TextProcess> createState() => _TextProcessState();
}

class _TextProcessState extends State<TextProcess> {
  String progress = 'Converting audio formats';
  String? flaclocation;
  bool flacconversion = false;
  late String summary;
  @override
  void initState() {
    mediaConvert(widget.filelocation).then((value) {
      if (value != null && value != '') {
        setState(() {
          flaclocation = value;
          progress = 'Uploading file to cloud storage';
        });
        gbucketUpload(flaclocation!).then((value) {
          if (value) {
            setState(() {
              progress = 'Using AI to transcribe and summarize';
            });
            try {
              audiosummarizer(trimLocation(flaclocation!)).then((value) {
                if (value != null) {
                  setState(() {
                    summary = value;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SummaryScreen(
                        summary: summary,
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    flacconversion = true;
                  });
                }
              });
            } catch (e) {
              setState(() {
                flacconversion = true;
              });
            }
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: SafeArea(
            child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              flacconversion
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '           Meeting Too Long \nPlease submit a shorter meeting',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              flacconversion
                  ? const SizedBox(
                      height: 15,
                    )
                  : Container(),
              flacconversion
                  ? SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FileSelection()));
                        },
                        child: const Text(
                          'Try Again',
                          style: TextStyle(fontSize: 23),
                        ),
                      ),
                    )
                  : Container(),
              !flacconversion
                  ? const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator())
                  : Container(),
              !flacconversion
                  ? const SizedBox(
                      height: 20,
                    )
                  : Container(),
              !flacconversion
                  ? Text('Loading',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? darkColorScheme.primary
                            : lightColorScheme.primary,
                      ))
                  : Container(),
              !flacconversion
                  ? Text(
                      progress,
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? darkColorScheme.primary
                            : lightColorScheme.primary,
                      ),
                    )
                  : Container(),
            ],
          ),
        )),
      ),
    );
  }
}
