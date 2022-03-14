import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<List<File>?> pickFiles({List<String>? extensions}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
      );

      if (result != null) {
        return result.paths.map((path) => File(path!)).toList();
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String> get localPath async {
    final directory = await getLibraryDirectory();

    return directory.path;
  }

  static XFile toXFile(File f) {
    return XFile(f.path);
  }

  static File toFile(XFile f) {
    return File(f.path);
  }
}
