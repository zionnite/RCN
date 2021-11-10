import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StudyWithApostle extends StatefulWidget {
  StudyWithApostle({Key? key, required this.seek_body, required this.seek_img})
      : super(key: key);

  String seek_img;
  String seek_body;

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
                      imageUrl: "${widget.seek_img}",
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 500),
                      fadeInCurve: Curves.easeIn,
                      placeholder: (context, progressText) => Center(
                        child: CircularProgressIndicator(
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
                    '${widget.seek_body}',
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
          width: 1.0,
        ),
      ],
    );
  }
}
