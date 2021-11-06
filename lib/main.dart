import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:rcn/component/bottom_nav.dart';
import 'package:rcn/component/page_manager.dart';
import 'package:rcn/controller/player_controller.dart';
import 'package:rcn/controller/slider_controller.dart';
import 'package:rcn/screens/announcement_screen.dart';
import 'package:rcn/screens/event_page_screen.dart';
import 'package:rcn/screens/home_page_screen.dart';
import 'package:rcn/screens/nearest_rcn_screen.dart';
import 'package:rcn/screens/profile_screen.dart';
import 'package:rcn/screens/read_daily_screen.dart';
import 'package:rcn/screens/speak_to_someone_screen.dart';
import 'package:rcn/screens/upcoming_itenary_screen.dart';
import 'package:rcn/services/service_locator.dart';

import 'screens/about_rcn_screen.dart';
import 'screens/give_n_partner_screen.dart';
import 'screens/itestify_screen.dart';
import 'screens/video_message_screen.dart';

const debug = true;

void main() async {
  Get.put(SliderController());
  Get.put(PlayerController());
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();
  await FlutterDownloader.initialize(debug: debug);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/first': (context) => HomePage(),
        '/second': (context) => EventPage(),
      },
      getPages: [
        GetPage(
          name: '/nav_bar',
          page: () => BottomNav(),
        ),
        GetPage(
          name: '/read_daily',
          page: () => ReadScriptureDaily(),
        ),
        GetPage(
          name: '/upcoming_itenary',
          page: () => UpcomingItenaryScreen(),
        ),
        // GetPage(
        //   name: '/audio_player',
        //   page: () => MessagePlayer(
        //     id: '1',
        //     title: 'Testing',
        //     album: 'Ministration',
        //     url: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
        //     artUri: 'https://www.ups.com/assets/resources/images/m4-international-shipping-services.jpg',
        //   ),
        // ),
        GetPage(
          name: '/video_player',
          page: () => VideoMessage(),
        ),
        GetPage(
          name: '/give_n_partner',
          page: () => GiveAndPartner(),
        ),
        GetPage(
          name: '/i_testify',
          page: () => ItestifyScreen(),
        ),
        GetPage(
          name: '/speak_to_someone',
          page: () => SpeakToSomeoneScreen(),
        ),
        GetPage(
          name: '/announcement',
          page: () => AnnouncementScreen(),
        ),
        GetPage(
          name: '/nearest_rcn',
          page: () => NearestRcnScreen(),
        ),
        GetPage(
          name: '/about_rcn',
          page: () => AboutRcn(),
        ),
        GetPage(
          name: '/profile_page',
          page: () => ProfileScreen(),
        ),
      ],
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
    //getIt<PlaylistPageManager>().init();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    //getIt<PlaylistPageManager>().dispose();
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
