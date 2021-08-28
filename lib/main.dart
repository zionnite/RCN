import 'package:flutter/material.dart';
import 'package:rcn/component/bottom_nav.dart';
import 'package:rcn/screens/event_page.dart';
import 'package:rcn/screens/home_page.dart';
import 'package:rcn/services/service_locator.dart';

void main() async {
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/first': (context) => HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BottomNav(),
    );
  }
}
