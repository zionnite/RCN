import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StudyWithApostle extends StatefulWidget {
  const StudyWithApostle({Key? key}) : super(key: key);

  @override
  _StudyWithApostleState createState() => _StudyWithApostleState();
}

class _StudyWithApostleState extends State<StudyWithApostle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          elevation: 2,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            // side: BorderSide(
            //   //color: primaryColorLight,
            //   width: 0,
            // ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          color: Colors.white,
          child: Container(
            width: 100.0,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://rcnauchi.com/other_img/greetings/b95e23dcebabc991a85b52bb62287300.jpeg",
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 500),
                      fadeInCurve: Curves.easeIn,
                      placeholder: (context, progressText) => Center(
                        child: CircularProgressIndicator(
                          value: 0.8,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.purple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Learning from the persecuted Church Learning from the persecuted ChurchLearning from the persecuted ChurchLearning from the persecuted ChurchLearning from the persecuted ChurchLearning from the persecuted ChurchLearning from the persecuted ChurchLearning from the persecuted Church Learning from the persecuted ChurchLearning from the persecuted ChurchLearning from the persecuted ChurchLearning from the persecuted ChurchLearning from the persecuted ChurchLearning from the persecuted Church',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.0,
                      // fontFamily: "Schyler",
                    ),
                    // overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
      ],
    );
  }
}
