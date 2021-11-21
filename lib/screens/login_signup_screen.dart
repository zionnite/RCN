import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:rcn/component/bottom_nav.dart';
import 'package:rcn/controller/login_signup_screen.dart';
import 'package:rcn/pallete.dart';
import 'package:rcn/screens/reset_password.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final lsController = LoginSignupController().getXID;

  bool isSignupScreen = true;
  bool isMale = true;
  bool isRememberMe = true;
  String user_name = '';
  late String password = '';
  late String email = '';
  late String login_email = '';
  late String login_password = '';
  bool isProcessing = false;

  final user_nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final login_emailController = TextEditingController();
  final login_passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/apostle.jpeg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Colors.red.withOpacity(.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Welcome ",
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: isSignupScreen ? "to RCN," : "Back,",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      isSignupScreen
                          ? "Signup to Continue"
                          : "Signin to Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the shadow for the submit button
          buildBottomHalfContainer(true),
          //Main Contianer for Login and Signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 280,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
          // Bottom buttons
          // Positioned(
          //   top: MediaQuery.of(context).size.height - 100,
          //   right: 0,
          //   left: 0,
          //   child: Column(
          //     children: [
          //       Text(isSignupScreen ? "Or Signup with" : "Or Signin with"),
          //       Container(
          //         margin: EdgeInsets.only(right: 20, left: 20, top: 15),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             buildTextButton(MaterialCommunityIcons.facebook,
          //                 "Facebook", Palette.facebookColor),
          //             buildTextButton(MaterialCommunityIcons.google_plus,
          //                 "Google", Palette.googleColor),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(
            Icons.mail_outline,
            "info@rcn.com",
            false,
            true,
            login_emailController,
            (value) {
              setState(() {
                login_email = value;
              });
            },
          ),
          buildTextField(
            MaterialCommunityIcons.lock_outline,
            "**********",
            true,
            false,
            login_passwordController,
            (value) {
              setState(() {
                login_password = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Palette.textColor2,
                    onChanged: (value) {
                      setState(() {
                        // isRememberMe = !isRememberMe;
                        isRememberMe = isRememberMe;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: TextStyle(fontSize: 12, color: Palette.textColor1))
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => ResetPassword());
                },
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12, color: Palette.textColor1)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(MaterialCommunityIcons.account_outline, "User Name",
              false, false, user_nameController, (value) {
            setState(() {
              user_name = value;
            });
          }),
          buildTextField(MaterialCommunityIcons.email_outline, "email", false,
              true, emailController, (value) {
            setState(() {
              email = value;
            });
          }),
          buildTextField(MaterialCommunityIcons.lock_outline, "password", true,
              false, passwordController, (value) {
            setState(() {
              password = value;
            });
          }),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
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
                          color:
                              isMale ? Palette.textColor2 : Colors.transparent,
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
                          color: isMale ? Colors.white : Palette.iconColor,
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
                          color:
                              isMale ? Colors.transparent : Palette.textColor2,
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
                          color: isMale ? Palette.iconColor : Colors.white,
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
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 15),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "By pressing 'Submit' you agree to our ",
                style: TextStyle(color: Palette.textColor2),
                children: [
                  TextSpan(
                    //recognizer: ,
                    text: "term & conditions",
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(145, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 535 : 460,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? InkWell(
                  onTap: () async {
                    if (isSignupScreen) {
                      setState(() {
                        user_nameController.text = '';
                        emailController.text = '';
                        passwordController.text = '';
                        isProcessing = true;
                      });

                      var gender;
                      if (isMale) {
                        setState(() {
                          gender = "Male";
                        });
                      } else {
                        setState(() {
                          gender = "Female";
                        });
                      }

                      var result = await lsController.signup(
                          user_name, email, password, gender);
                      Future.delayed(new Duration(seconds: 4), () {
                        if (result == "success") {
                          showSnackBar("Congratulation",
                              "Your Registration was successful", Colors.green);
                          Future.delayed(new Duration(seconds: 4), () {
                            Get.offAll(
                              () => BottomNav(),
                              transition: Transition.leftToRightWithFade,
                            );
                          });
                        } else if (result == "fail_01") {
                          showSnackBar(
                              "Oops!!",
                              "Signup Successful, could not redirect you to the App Home, Please click go back to the login page, to gain access to app!",
                              Colors.red);
                        } else if (result == "fail_02") {
                          showSnackBar(
                              "Oops!!",
                              "Registration was not successful, please try after some time!",
                              Colors.red);
                        } else if (result == "fail_03") {
                          showSnackBar(
                              "Oops!!",
                              "Email or Password can not be empty!",
                              Colors.red);
                        } else if (result == "fail_04") {
                          showSnackBar(
                              "Oops!!",
                              "Someone with this Username already exist on our platform!",
                              Colors.red);
                        } else if (result == "fail_05") {
                          showSnackBar(
                              "Oops!!",
                              "Someone with this email already exist on our platform!",
                              Colors.red);
                        } else {
                          showSnackBar("Oops!!", "Unidentified error occur",
                              Colors.deepOrange);
                        }
                        setState(() {
                          isProcessing = false;
                        });
                      });
                    } else {
                      setState(() {
                        login_emailController.text = '';
                        login_passwordController.text = '';
                        isProcessing = true;
                      });
                      var result =
                          await lsController.login(login_email, login_password);

                      Future.delayed(new Duration(seconds: 4), () {
                        if (result == "success") {
                          showSnackBar("Redirecting...", "Login successful",
                              Colors.green);
                          Future.delayed(new Duration(seconds: 4), () {
                            Get.offAll(
                              () => BottomNav(),
                              transition: Transition.leftToRightWithFade,
                            );
                          });
                        } else if (result == "fail_01") {
                          showSnackBar(
                              "Oops!!",
                              "User not found or Password is incorrect!",
                              Colors.red);
                        } else if (result == "fail_02") {
                          showSnackBar(
                              "Oops!!",
                              "Email Or Password can not be empty!",
                              Colors.red);
                        } else {
                          showSnackBar("Oops!!", "Unidentified error occur",
                              Colors.deepOrange);
                        }

                        setState(() {
                          isProcessing = false;
                        });
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange.shade200, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1))
                        ]),
                    child: (isProcessing)
                        ? CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                  ),
                )
              : Center(),
        ),
      ),
    );
  }

  Widget buildTextField(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller, textValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        onChanged: textValue,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
          //errorText: validatePassword(controller.text),
        ),
      ),
    );
  }

  String? validatePassword(String value) {
    if ((value.length <= 5) && value.isEmpty) {
      return "Required and it must be more than 5 letters";
    }
    return null;
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
