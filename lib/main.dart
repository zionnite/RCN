import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:rcn/component/bottom_nav.dart';
import 'package:rcn/component/page_manager.dart';
import 'package:rcn/controller/slider_controller.dart';
import 'package:rcn/screens/event_page.dart';
import 'package:rcn/screens/home_page.dart';
import 'package:rcn/services/service_locator.dart';

const debug = true;

void main() async {
  Get.put(SliderController());
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();
  await FlutterDownloader.initialize(debug: debug);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/first': (context) => HomePage(),
        '/second': (context) => EventPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BottomNav(),
    );
  }
}
