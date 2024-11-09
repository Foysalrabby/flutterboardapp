

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterboardapp/boardapp/Util/Timeformat.dart';

class Customcard extends StatelessWidget{
  final DocumentSnapshot snapshot;
  final int index;

 // const Customcard({super.key, required this.snapshot, required this.index});
  const Customcard({
    Key? key,
    required this.snapshot,
    required this.index,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Timestamp timestamp=snapshot['timestamp'];
   String datetimeformat= TimeFormat.formatTimestamp(timestamp);
    return Container(
      height: 150,
      child: Card(
        elevation: 10,
        child: Column(
          children: [

            ListTile(
             title: Text(snapshot['title']),
              subtitle: Text(snapshot['describtin']),
              leading: CircleAvatar(
                radius: 50,
                child: Text(snapshot['title'].toString()[0]),
              ),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(snapshot['username']),
                  Text(" By ${datetimeformat}"),
                ],
              )
          ],
        ),
      ),
    );
  }

}