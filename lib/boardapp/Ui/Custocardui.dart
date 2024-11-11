

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterboardapp/boardapp/Util/Timeformat.dart';

class Customcard extends StatelessWidget{
  final DocumentSnapshot snapshot;
  final int index;
  final VoidCallback ondelete;
  final Function(Map<String, dynamic> updatedData) onUpdate; // Add update callback

 // const Customcard({super.key, required this.snapshot, required this.index});
  const Customcard({
    Key? key,
    required this.snapshot,
    required this.index,
    required this.ondelete,
    required this.onUpdate

  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Timestamp timestamp=snapshot['timestamp'];
   String datetimeformat= TimeFormat.formatTimestamp(timestamp);
    return Container(
      height: 170,
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
              Padding(
                padding:EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(snapshot['username']),
                    Text(" By ${datetimeformat}"),
                  ],
                ),
              ),
            Padding(
                padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){
                  editDialog(context);
                }, icon:Icon(Icons.edit)),
                IconButton(onPressed:ondelete, icon:Icon(Icons.delete))
              ],
            ) )

          ],
        ),
      ),
    );
  }

  void editDialog(BuildContext context) {
        TextEditingController usernameController=TextEditingController(text: snapshot['username']);
        TextEditingController titleController=TextEditingController(text: snapshot['title']);
        TextEditingController descriptionController=TextEditingController(text: snapshot['describtin']);
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Update the data"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     TextField(
                       autocorrect: true,
                       autofocus: true,
                       decoration: InputDecoration(
                         labelText: "Edit the name"
                       ),
                      controller: usernameController,
                     ),
                    TextField(
                      autocorrect: true,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: "Edit the title"
                      ),
                      controller: titleController,
                    ),
                    TextField(
                      autocorrect: true,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: "Edit the describtion"
                      ),
                     controller: descriptionController,
                    ),


                  ],
                ),
              ),
              actions: [

                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text("cancel")) ,
                  TextButton(onPressed: (){
                    onUpdate({
                      'username': usernameController.text,
                      'title': titleController.text,
                      'describtin': descriptionController.text,

                    });
                    Navigator.of(context).pop();

                  }, child: Text("save"))

              ],

            );
          });
  }

}