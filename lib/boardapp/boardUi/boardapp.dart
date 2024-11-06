import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Boardapp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Extendboardapp();
  }
}

class Extendboardapp extends State<Boardapp> {
  // final CollectionReference<Map<String, dynamic>> firestoreCollection =
  // FirebaseFirestore.instance.collection("fboard");
  TextEditingController? nameInputcontroller;
  TextEditingController? tittleInputcontroller;
  var Firebasedb=FirebaseFirestore.instance.collection('fboard').snapshots();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameInputcontroller = TextEditingController();
    tittleInputcontroller=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameInputcontroller?.dispose();
    tittleInputcontroller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Board App"),
        backgroundColor: Colors.orangeAccent,
      ),
       floatingActionButton: FloatingActionButton(onPressed: (){
         showDialogBox(context);
       },
         child: Icon(Icons.pin_end),
       ),

       body:StreamBuilder<QuerySnapshot>(
              stream: Firebasedb,
            builder: (context,snapshot){
                 if(!snapshot.hasData){
                   return CircularProgressIndicator();
                  }
         final List<DocumentSnapshot> documents = snapshot.data!.docs;
               return ListView.builder(
               itemCount:documents.length,
               itemBuilder: (context,int index){
             return Text(documents [index]['tittle']);
               }
               );
           },
       ),

    );
  }

  Future<void> showDialogBox(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter your Information"),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Fit dialog to content size
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: "Name*"),
                controller: nameInputcontroller,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Title*"),
                controller: tittleInputcontroller,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without saving
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (nameInputcontroller!.text.isNotEmpty &&
                    tittleInputcontroller!.text.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('fboard').add({
                    'name': nameInputcontroller!.text,
                    'title': tittleInputcontroller!.text,
                    'timestamp': Timestamp.now(),
                  });
                  nameInputcontroller!.clear();
                  tittleInputcontroller!.clear();
                  Navigator.of(context).pop(); // Close dialog after saving
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}



