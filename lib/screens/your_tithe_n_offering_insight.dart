import 'package:flutter/material.dart';

class YourTitheNOferringInsight extends StatefulWidget {
  const YourTitheNOferringInsight({Key? key}) : super(key: key);

  @override
  _YourTitheNOferringInsightState createState() =>
      _YourTitheNOferringInsightState();
}

class _YourTitheNOferringInsightState extends State<YourTitheNOferringInsight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          'Offring & Tithe Insight',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
