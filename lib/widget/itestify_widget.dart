import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:rcn/controller/itestify_controller.dart';

class ItestifyWidget extends StatefulWidget {
  ItestifyWidget({
    Key? key,
    required this.test_img,
    required this.test_full_name,
    required this.test_user_name,
    required this.test_counter,
    required this.test_body,
    required this.isTestLike,
    required this.user_id,
    required this.test_id,
  }) : super(key: key);
  String test_img;
  String test_full_name;
  String test_user_name;
  int test_counter;
  String test_body;
  bool isTestLike;
  String test_id;
  String user_id;

  @override
  _ItestifyWidgetState createState() => _ItestifyWidgetState();
}

class _ItestifyWidgetState extends State<ItestifyWidget> {
  final itestListController = ItestifyController().getXID;
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
                CircleAvatar(
                  backgroundImage: NetworkImage('${widget.test_img}'),
                  radius: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.test_full_name}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.test_user_name}',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert_sharp,
                  ),
                  enabled: true,
                  onSelected: (value) {
                    setState(() {
                      // _value = value;
                      //print(_value);
                    });
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Report Post"),
                      value: "Report",
                    ),
                    PopupMenuItem(
                      child: Text("Block User"),
                      value: "Block",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ExpandableText(
              '${widget.test_body}',
              style: TextStyle(),
              expandText: 'Show More',
              collapseText: 'Show Less',
              maxLines: 3,
              linkColor: Colors.red,
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              children: [
                (widget.isTestLike)
                    ? IconButton(
                        onPressed: () async {
                          var toggle = await itestListController.toggle_testify(
                              widget.user_id, widget.test_id);

                          if (toggle == "deleted") {
                            setState(() {
                              widget.isTestLike = false;
                              widget.test_counter--;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.thumb_up,
                          color: Colors.red,
                        ),
                      )
                    : IconButton(
                        onPressed: () async {
                          var toggle = await itestListController.toggle_testify(
                              widget.user_id, widget.test_id);

                          if (toggle == "added") {
                            setState(() {
                              widget.isTestLike = true;
                              widget.test_counter++;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.thumb_up_outlined,
                          color: Colors.red,
                        ),
                      ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      '${widget.test_counter}',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
