import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class AnnouncementWidget extends StatefulWidget {
  AnnouncementWidget({
    Key? key,
    required this.an_img,
    required this.an_body,
    required this.an_date,
  }) : super(key: key);

  String an_img;
  String an_body;
  String an_date;

  @override
  _AnnouncementWidgetState createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('${widget.an_img}'),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  'Date:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.an_date}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ExpandableText(
              '${widget.an_body}',
              style: TextStyle(),
              expandText: 'Show More',
              collapseText: 'Show Less',
              maxLines: 3,
              linkColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
