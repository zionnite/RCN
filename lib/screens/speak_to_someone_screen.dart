import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcn/controller/send_message_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpeakToSomeoneScreen extends StatefulWidget {
  const SpeakToSomeoneScreen({Key? key}) : super(key: key);

  @override
  _SpeakToSomeoneScreenState createState() => _SpeakToSomeoneScreenState();
}

class _SpeakToSomeoneScreenState extends State<SpeakToSomeoneScreen> {
  TextEditingController messageController = TextEditingController();
  final sendMsgController = SendMessageController().getXID;
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? name;
  late String msg;
  bool isSubmitting = false;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserLogin = prefs.getBool('isUserLogin');
    var user_id1 = prefs.getString('user_id');
    var user_name1 = prefs.getString('user_name');
    var user_full_name = prefs.getString('full_name');
    var user_email = prefs.getString('email');
    var user_img1 = prefs.getString('user_img');
    var user_age = prefs.getString('age');
    var phone_no1 = prefs.getString('phone_no');

    setState(() {
      name = user_full_name!;
      email = user_email!;
    });
  }

  @override
  void initState() {
    super.initState();
    _initUserDetail();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
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
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      //controller: messageController,
                      maxLines: 8,
                      onChanged: (value) async {
                        setState(() {
                          msg = value;
                          // messageController.text = '';
                        });
                      },

                      decoration: InputDecoration(
                        hintText: "Enter your text here ...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red, //this has no effect
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length <= 50) {
                          return 'Text too short (Test must be above 50 Length';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isSubmitting = true;
                  });

                  await sendMsgController.send(email, name, msg);
                  Future.delayed(new Duration(seconds: 2), () async {
                    setState(() {
                      isSubmitting = false;
                    });
                  });
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(250),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 50),
                  child: (isSubmitting)
                      ? CircularProgressIndicator()
                      : Text(
                          'Send Message',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                elevation: 5.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
