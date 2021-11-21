import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rcn/controller/login_signup_screen.dart';
import 'package:rcn/pallete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final lsController = LoginSignupController().getXID;

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();

  bool isMale = true;
  bool isPro = false;
  String? user_id;
  String? user_name;
  late String full_name;
  late String phone_no;
  late String age;

  File? profileImg;
  final profilePiker = ImagePicker();

  Future choiceProfileImg() async {
    var pickedProfileImg =
        await profilePiker.getImage(source: ImageSource.gallery);
    setState(() {
      profileImg = File(pickedProfileImg!.path);
    });
  }

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id1 = prefs.getString('user_id');
    var user_name1 = prefs.getString('user_name');

    setState(() {
      user_id = user_id1!;
      user_name = user_name1!;
    });
  }

  @override
  void initState() {
    super.initState();
    _initUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('All Field is Important'),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: fullNameController,
                        onChanged: (value) {
                          setState(() {
                            full_name = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your Fullname',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length <= 5) {
                            return 'Full Name too short';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: phoneController,
                        onChanged: (value) {
                          setState(() {
                            phone_no = value;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your Phone Number',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        choiceProfileImg();
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(18.0),
                          width: double.infinity,
                          child: Text(
                            'Select Profile Pic',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: (profileImg == null)
                          ? Text(
                              'No Image Selected',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 3.0),
                              child: Image.file(profileImg!),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: ageController,
                        onChanged: (value) {
                          setState(() {
                            age = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your Age',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMale = true;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: isMale
                                        ? Palette.textColor2
                                        : Colors.transparent,
                                    border: Border.all(
                                      width: 1,
                                      color: isMale
                                          ? Colors.transparent
                                          : Palette.textColor1,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    MaterialCommunityIcons.account_outline,
                                    color: isMale
                                        ? Colors.white
                                        : Palette.iconColor,
                                  ),
                                ),
                                Text(
                                  "Male",
                                  style: TextStyle(color: Palette.textColor1),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMale = false;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: isMale
                                        ? Colors.transparent
                                        : Palette.textColor2,
                                    border: Border.all(
                                      width: 1,
                                      color: isMale
                                          ? Palette.textColor1
                                          : Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    MaterialCommunityIcons.account_outline,
                                    color: isMale
                                        ? Palette.iconColor
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(color: Palette.textColor1),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8),
                      child: InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isPro = true;
                            });

                            var result = await lsController.updateProfile(
                                full_name,
                                phone_no,
                                age,
                                isMale.toString(),
                                profileImg,
                                user_id,
                                user_name);
                            if (result) {
                              showSnackBar(
                                  'Congratulations!',
                                  'Your Details was updated successfully',
                                  Colors.green);
                              setState(() {
                                fullNameController.text = '';
                                phoneController.text = '';
                                ageController.text = '';
                                profileImg = null;
                              });
                            } else {
                              showSnackBar(
                                  'Oops!!',
                                  'Could not update your profile, try later or contact admin',
                                  Colors.red);
                            }

                            Future.delayed(new Duration(seconds: 2), () {
                              setState(() {
                                isPro = false;
                              });
                            });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          color: Colors.redAccent,
                          padding: EdgeInsets.all(20),
                          child: (isPro)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showSnackBar(String title, String msg, Color backgroundColor) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
