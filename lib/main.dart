import 'package:flutter/material.dart';
import 'package:rcn/component/bottom_nav.dart';
import 'package:rcn/component/page_manager.dart';
import 'package:rcn/screens/event_page.dart';
import 'package:rcn/screens/home_page.dart';
import 'package:rcn/services/service_locator.dart';

void main() async {
  await setupServiceLocator();

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
  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
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
