import 'package:flutter/material.dart';
import 'package:speechsummarizer/color_schemes.g.dart';

class UploadCard extends StatefulWidget {
  final String filename;
  final double filesize;
  const UploadCard({super.key, required this.filename, required this.filesize});

  @override
  State<UploadCard> createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? darkColorScheme.secondaryContainer
              : lightColorScheme.primaryContainer,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                (widget.filename.length > 29)
                    ? '${widget.filename.substring(0, 20)}...${widget.filename.substring(widget.filename.length - 7)}'
                    : widget.filename,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('${widget.filesize.toString()} kb')
            ],
          ),
        ),
      ),
    );
  }
}
