import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpeakToSomeoneScreen extends StatefulWidget {
  const SpeakToSomeoneScreen({Key? key}) : super(key: key);

  @override
  _SpeakToSomeoneScreenState createState() => _SpeakToSomeoneScreenState();
}

class _SpeakToSomeoneScreenState extends State<SpeakToSomeoneScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Speak To Us!'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                bottom: 8.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Text(
                'We care about you, Let\'s us know how we can be of help',
                style: GoogleFonts.lancelot(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              child: Container(
                height: 300.0,
                child: Material(
                  color: Colors.white,
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: TextField(
                    onChanged: null,
                    maxLines: null,
                    controller: messageController,
                    style: TextStyle(),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 18.0),
                      border: InputBorder.none,
                      hintText: 'Enter Message',
                      errorText: 'snapshot.error',
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(250),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 50),
                child: Text(
                  'Send Message',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              elevation: 5.0,
            )
          ],
        ),
      ),
    );
  }
}
