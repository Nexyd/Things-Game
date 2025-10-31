import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileWriter {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/firestore_logs.txt');
  }

  Future<void> write(String msg) async {
    final file = await _localFile;
    await file.writeAsString(msg);
  }
}