import 'package:flutter/material.dart';
import 'package:rcn/widget/itestify_widget.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class ItestifyScreen extends StatefulWidget {
  const ItestifyScreen({Key? key}) : super(key: key);

  @override
  _ItestifyScreenState createState() => _ItestifyScreenState();
}

class _ItestifyScreenState extends State<ItestifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'iTestify',
              style: TextStyle(),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.add,
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: SpeedDialFabWidget(
        secondaryIconsList: [
          Icons.add,
        ],
        secondaryIconsText: [
          "Share Testimony",
        ],
        secondaryIconsOnPress: [
          () => {callBottomSheet()},
        ],
        secondaryBackgroundColor: Colors.grey[900],
        secondaryForegroundColor: Colors.grey[100],
        primaryBackgroundColor: Colors.deepOrange,
        primaryForegroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                ItestifyWidget(
                  test_img:
                      'https://rcnsermons.org/wp-content/uploads/2020/05/Apostle-Arome-Osayi-365x365.png',
                  test_full_name: 'Nosakhare Atekha Endurance',
                  test_user_name: 'zionnite',
                  test_counter: '10',
                  test_body:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  isTestLike: true,
                ),
                ItestifyWidget(
                  test_img:
                      'https://rcnsermons.org/wp-content/uploads/2020/05/Apostle-Arome-Osayi-365x365.png',
                  test_full_name: 'Jessica Margret',
                  test_user_name: 'meggie',
                  test_counter: '1000',
                  test_body:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  isTestLike: false,
                ),
                ItestifyWidget(
                  test_img:
                      'https://rcnsermons.org/wp-content/uploads/2020/05/Apostle-Arome-Osayi-365x365.png',
                  test_full_name: 'Edobor Elubor',
                  test_user_name: 'elobor',
                  test_counter: '4',
                  test_body:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  isTestLike: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  callBottomSheet() {
    print('Sheet Called');
  }
}
