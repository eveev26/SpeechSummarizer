import 'dart:convert';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speechsummarizer/keys.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:ffmpeg_kit_flutter/return_code.dart';

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
  if (fileLocation.substring(fileLocation.lastIndexOf('.') + 1) != 'flac') {
    String fileFlac =
        '${fileLocation.substring(0, fileLocation.lastIndexOf('.') + 1)}flac';
    fileFlac = fileFlac.replaceAll(" ", "");
    try {
      final session = await FFmpegKit.execute(
          '-i \'$fileLocation\' -vn -acodec flac $fileFlac');
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode) || File(fileFlac).existsSync()) {
        return fileFlac;
      } else {
        return '';
      }
    } catch (e) {}
  } else {
    return fileLocation;
  }
  return null;
}

Future<bool> gbucketUpload(String flacLocation) async {
  var headers = {
    'Authorization': 'Bearer $gbucketapi',
    'Content-Type': 'audio/flac',
  };
  var request = http.Request(
    'POST',
    Uri.parse(
      'https://storage.googleapis.com/upload/storage/v1/b/audio-file-hackathon/o?uploadType=media&name=${Uri.encodeComponent(trimLocation(flacLocation))}',
    ),
  );
  List<int> binaryData = await File(flacLocation).readAsBytes();
  request.bodyBytes = binaryData;
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<String?> audiosummarizer(String filename) async {
  var gbucketlocation = 'gs://audio-file-hackathon/$filename';
  final url = Uri.parse('http://34.134.208.93:3002/speech-to-text');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    'file_url': gbucketlocation,
  });

  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    final responseBody = json.decode(response.body);

    return responseBody.toString();
  } else {}
  return null;
}
