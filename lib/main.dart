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
import 'package:rcn/screens/login_signup_screen.dart';
import 'package:rcn/screens/nearest_rcn_screen.dart';
import 'package:rcn/screens/onboarding_screen.dart';
import 'package:rcn/screens/profile_screen.dart';
import 'package:rcn/screens/speak_to_someone_screen.dart';
import 'package:rcn/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/announcement_controller.dart';
import 'controller/audio_msg_controller.dart';
import 'controller/itestify_controller.dart';
import 'controller/itinerary_controller.dart';
import 'controller/live_message_controller.dart';
import 'controller/login_signup_screen.dart';
import 'controller/nearest_rcn_controller.dart';
import 'controller/seek_god_controller.dart';
import 'controller/send_message_controller.dart';
import 'controller/video_msg_controller.dart';
import 'screens/about_rcn_screen.dart';
import 'screens/give_n_partner_screen.dart';
import 'screens/itestify_screen.dart';
import 'screens/video_message_screen.dart';

const debug = true;

//this is the name given to the background fetch
// const liveStreamingStatus = "check_for_live_streaming_status";
// // flutter local notification setup
// void showNotification(v, flp) async {
//   var android = AndroidNotificationDetails(
//     'live_status',
//     'Live Streaming',
//     channelDescription: 'To Check if RCN is ministering Live',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   var iOS = IOSNotificationDetails();
//   var platform = NotificationDetails(android: android, iOS: iOS);
//   await flp.show(0, 'Remnant Christian Network', '$v', platform,
//       payload: 'RCN \n $v');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(SliderController());
  Get.put(PlayerController());
  Get.put(SeekGodController());
  Get.put(ItineraryController());
  Get.put(AudioMsgController());
  Get.put(VideoMsgController());
  Get.put(AnnouncementController());
  Get.put(NearestRcnController());
  Get.put(ItestifyController());
  Get.put(SendMessageController());
  Get.put(LiveMessageController());
  Get.put(LoginSignupController());

  await setupServiceLocator();
  await FlutterDownloader.initialize(debug: debug);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  // await Workmanager().registerPeriodicTask("5", liveStreamingStatus,
  //     existingWorkPolicy: ExistingWorkPolicy.replace,
  //     frequency: Duration(minutes: 15),
  //     initialDelay: Duration(seconds: 5),
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //     ));

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isUserLogin = prefs.getBool('isUserLogin');
  var isFirstTime = prefs.getBool('isFirstTime');

  runApp(MyApp(isUserLogin: isUserLogin, isFirstTime: isFirstTime));
}
//
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
//     var android = AndroidInitializationSettings('@drawable/rcn');
//     var iOS = IOSInitializationSettings();
//     var initSetttings = InitializationSettings(android: android, iOS: iOS);
//     flp.initialize(initSetttings);
//
//     var response = await http.post(
//         Uri.parse('https://arome.joons-me.com/api/get_live_streaming_status'));
//     print("RESponse  === ${response}");
//     var convert = json.decode(response.body);
//     if (convert['status'] == "true") {
//       print("Work Manager ${convert['status']}");
//       showNotification(
//         'RCN is Live, open App to capture the Moment for you!',
//         flp,
//       );
//       //final liveMsg = LiveMessageController().getXID;
//       //liveMsg.isLive = true as RxBool;
//     } else {
//       //print("no message");
//       //showNotification('No Message', flp);
//     }
//
//     switch (task) {
//       case Workmanager.iOSBackgroundTask:
//         stderr.writeln("The iOS background fetch was triggered");
//         break;
//     }
//
//     return Future.value(true);
//   });
// }

class MyApp extends StatefulWidget {
  MyApp({required this.isUserLogin, required this.isFirstTime});
  late var isUserLogin;
  late var isFirstTime;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget.isFirstTime != null
          ? OnBoardingScreen()
          : MyHomePage(isUserLogin: widget.isUserLogin),
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
  MyHomePage({Key? key, required this.isUserLogin}) : super(key: key);
  late var isUserLogin;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int progress = 0;
  //
  // ReceivePort _receivePort = ReceivePort();
  //
  // static downloadingCallback(id, status, progress) {
  //   ///Looking up for a send port
  //   final SendPort? sendPort =
  //       IsolateNameServer.lookupPortByName("downloading");
  //
  //   ///ssending the data
  //   sendPort!.send([id, status, progress]);
  // }
  //
  // static void downloadCallback(
  //     String id, DownloadTaskStatus status, int progress) {
  //   if (debug) {
  //     print(
  //         'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
  //   }
  //   final SendPort send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port')!;
  //   send.send([id, status, progress]);
  // }

  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
    //getIt<PlaylistPageManager>().init();

    // IsolateNameServer.registerPortWithName(
    //     _receivePort.sendPort, "downloading");
    //
    // _receivePort.listen((message) {
    //   setState(() {
    //     progress = message[2];
    //   });
    //
    //   print(progress);
    // });
    //
    // FlutterDownloader.registerCallback(downloadingCallback);
    //FlutterDownloader.registerCallback(downloadCallback);
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
      body: (widget.isUserLogin = false) ? BottomNav() : LoginSignupScreen(),
      // body: (widget.isUserLogin = false) ? BottomNav() : ResetPassword(),
    );
  }
}
