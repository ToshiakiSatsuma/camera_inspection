import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_inspection/camera_test_screen.dart';
import 'package:camera_inspection/utils/file_utils.dart';
import 'package:camera_inspection/utils/media_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale("en"),
        Locale("ja"),
      ],
      locale: const Locale('ja', 'JP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                MediaUtils.takeImage();
              },
              child: const Text('カメラで写真を撮影'),
            ),
            TextButton(
              onPressed: () {
                MediaUtils.takeVideo();
              },
              child: const Text('カメラで動画を撮影'),
            ),
            TextButton(
              onPressed: () {
                MediaUtils.pickSingleImage();
              },
              child: const Text('ギャラリーから写真を１枚取得'),
            ),
            TextButton(
              onPressed: () {
                MediaUtils.pickMultiImage();
              },
              child: const Text('ギャラリーから写真を複数枚取得'),
            ),
            TextButton(
              onPressed: () {
                MediaUtils.pickLimitedMultiImage();
              },
              child: const Text('ギャラリーから写真を４枚まで取得'),
            ),
            TextButton(
              onPressed: () {
                MediaUtils.pickVideo();
              },
              child: const Text('ギャラリーから動画を取得'),
            ),
            TextButton(
              onPressed: () {
                FileUtils.pickFiles();
              },
              child: const Text('ファイルを取得'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraExampleHome(),
                  ),
                );
              },
              child: const Text('カメラテスト画面へ遷移'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
