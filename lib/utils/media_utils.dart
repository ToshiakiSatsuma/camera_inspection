import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera_inspection/utils/common_utils.dart';
import 'package:camera_inspection/utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class MediaUtils {
  static Future<File?> pickSingleImage() async {
    try {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (file != null) {
        return FileUtils.toFile(file);
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<File>?> pickMultiImage() async {
    try {
      List<XFile>? files = await ImagePicker().pickMultiImage();

      if (files != null) {
        return files.map((XFile file) => FileUtils.toFile(file)).toList();
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<File>?> pickLimitedMultiImage({
    int maxImages = 4,
  }) async {
    try {
      List<Asset> assets = await MultiImagePicker.pickImages(
        maxImages: maxImages,
        cupertinoOptions: const CupertinoOptions(
          doneButtonTitle: '保存',
        ),
      );

      final files = <File>[];

      await Future.wait(
        assets.map(
              (e) async {
            final path = await FlutterAbsolutePath.getAbsolutePath(e.identifier!);
            final file = File(path!);
            files.add(file);
          },
        ),
      );
    } catch (e) {
      return null;
    }
  }

  static Future<File?> takeImage() async {
    try {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);

      if (file != null) {
        return FileUtils.toFile(file);
      }
    } catch (e) {
      return null;
    }
  }
  static Future<File?> pickVideo() async {
    try {
      XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);

      if (file != null) {
        return FileUtils.toFile(file);
      }
    } catch (e) {
      return null;
    }
  }

  static Future<File?> takeVideo() async {
    try {
      XFile? file = await ImagePicker().pickVideo(source: ImageSource.camera);

      if (file != null) {
        return FileUtils.toFile(file);
      }
    } catch (e) {
      return null;
    }
  }

  static Future<File?> pickImageAndVideo() async {
    try {
      XFile? file = await ImagePicker().pickVideo(source: ImageSource.camera);

      if (file != null) {
        return FileUtils.toFile(file);
      }
    } catch (e) {
      return null;
    }
  }

  static ImageProvider getLibraryImageProvider({
    required String libraryPath,
  }) {
    return FileImage(File(libraryPath));
  }

  static List<ImageProvider> getLibraryImageProviders({
    required List<String> libraryPaths,
  }) {
    return libraryPaths.map((String libraryPath) {
      return getLibraryImageProvider(libraryPath: libraryPath);
    }).toList();
  }

  static ImageProvider getNetworkImageProvider({
    required String storagePath,
  }) {
    return CachedNetworkImageProvider(storagePath);
  }

  static List<ImageProvider> getNetworkImageProviders({
    required List<String> storagePaths,
  }) {
    return storagePaths.map((String storagePath) {
      return getNetworkImageProvider(storagePath: storagePath);
    }).toList();
  }

  static Future<Uint8List> getLibraryImageBytes({
    required String libraryPath,
  }) async {
    ByteData bytes = await rootBundle.load(libraryPath);

    return bytes.buffer.asUint8List();
  }

  static Future<Uint8List> getNetworkImageBytes({
    required String networkImagePath,
  }) async {
    ByteData bytes = await NetworkAssetBundle(Uri.parse(networkImagePath)).load(networkImagePath);

    return bytes.buffer.asUint8List();
  }

  static Future<File> saveBytesImage(Uint8List image) async {
    // ギャラリーに保存
    await ImageGallerySaver.saveImage(
      image,
      isReturnImagePathOfIOS: true,
    );

    // ディレクトリに保存
    final imagePath = '${await FileUtils.localPath}/${DateTime.now().toString()}-${CommonUtils.randomString(10)}.jpg';
    File imageFile = await File(imagePath).writeAsBytes(image);

    // ディレクトリに保存したファイルを返す
    return imageFile;
  }
}
