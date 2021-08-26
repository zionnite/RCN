import 'package:flutter/material.dart';
import 'package:rcn/util.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColorDark,
        body: Column(
          children: [Text('Reminant')],
        ),
      ),
    );
  }
}
