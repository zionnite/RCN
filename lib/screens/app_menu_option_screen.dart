import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rcn/component/app_title_widget.dart';
import 'package:rcn/controller/player_controller.dart';
import 'package:rcn/controller/slider_controller.dart';
import 'package:rcn/screens/about_rcn.dart';
import 'package:rcn/screens/announcement_screen.dart';
import 'package:rcn/screens/give_n_partner_screen.dart';
import 'package:rcn/screens/itestify_screen.dart';
import 'package:rcn/screens/list_messages_screen.dart';
import 'package:rcn/screens/nearest_rcn_screen.dart';
import 'package:rcn/screens/profile_screen.dart';
import 'package:rcn/screens/speak_to_someone_screen.dart';
import 'package:rcn/screens/video_message_screen.dart';

class AppMenuOption extends StatefulWidget {
  const AppMenuOption({Key? key}) : super(key: key);

  @override
  _AppMenuOptionState createState() => _AppMenuOptionState();
}

class _AppMenuOptionState extends State<AppMenuOption> {
  final sliderCont = SliderController().getXID;
  final playerCont = PlayerController().getXID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appTitleWidget(
              title: 'Menu',
              toNav: '',
            ),
            Container(
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ListMessagesScreen(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.audiotrack,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            'Audio Messages',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Listen and Download Audio Message',
                          ),
                          trailing: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70.0,
                          ),
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => VideoMessage(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.video_collection_rounded,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            'Video Messages',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Listen and Download Video Message',
                          ),
                          trailing: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70.0,
                          ),
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => GiveAndPartner(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.volunteer_activism,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            'Tithes & Offering',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Give Your Offering and Pay Your Tithe',
                          ),
                          trailing: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70.0,
                          ),
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ItestifyScreen(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.account_tree_rounded,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            'iTestify',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Share and Read Testimony of others',
                          ),
                          trailing: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70.0,
                          ),
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => SpeakToSomeoneScreen(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.record_voice_over,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            'Speak To Someone',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Not sure what\'s going on in your life?',
                          ),
                          trailing: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70.0,
                          ),
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => AnnouncementScreen(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.add_alert_rounded,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            'Announcement',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Get updated with the current information',
                          ),
                          trailing: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70.0,
                          ),
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => NearestRcnScreen(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.location_on_sharp,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            'Nearest RCN Point',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Find and Locate your nearest precious RCN',
                          ),
                          trailing: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70.0,
                          ),
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => AboutRcn(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.file_copy_outlined,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            'About RCN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Read about RCN mission and vision statement',
                          ),
                          trailing: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70.0,
                          ),
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ProfileScreen(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            'Profile',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Manage your profile',
                          ),
                          trailing: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
