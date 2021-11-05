import 'package:flutter/material.dart';

class AboutRcn extends StatefulWidget {
  const AboutRcn({Key? key}) : super(key: key);

  @override
  _AboutRcnState createState() => _AboutRcnState();
}

class _AboutRcnState extends State<AboutRcn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('About RCN'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
