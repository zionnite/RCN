import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadScriptureDaily extends StatefulWidget {
  ReadScriptureDaily(
      {Key? key, required this.title, required this.desc, required this.image})
      : super(key: key);

  String title;
  String desc;
  String image;

  @override
  _ReadScriptureDailyState createState() => _ReadScriptureDailyState();
}

class _ReadScriptureDailyState extends State<ReadScriptureDaily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.image,
                height: 450,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  left: 10,
                  right: 10,
                ),
                child: Text(
                  widget.title,
                  style: GoogleFonts.lancelot(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  bottom: 10,
                  right: 10,
                ),
                child: Text(
                  widget.desc,
                  style: GoogleFonts.oxygen(
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
