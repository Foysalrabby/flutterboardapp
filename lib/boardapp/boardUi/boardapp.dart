
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterboardapp/boardapp/Ui/Custocardui.dart';

class Boardapp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Extendboardapp();
  }
}

class Extendboardapp extends State<Boardapp> {
   final CollectionReference<Map<String, dynamic>> firestoreCollection =
   FirebaseFirestore.instance.collection("fboard");
  TextEditingController? nameInputcontroller;
  TextEditingController? tittleInputcontroller;
  TextEditingController? decrInputcontroller;
  //var Firebasedb=FirebaseFirestore.instance.collection('fboard').snapshots();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameInputcontroller = TextEditingController();
    tittleInputcontroller=TextEditingController();
    decrInputcontroller=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameInputcontroller?.dispose();
    tittleInputcontroller?.dispose();
    decrInputcontroller?.dispose();
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
              stream: firestoreCollection.snapshots(),
            builder: (context,snapshot){
                 if(!snapshot.hasData){
                   return CircularProgressIndicator();
                  }
         final List<DocumentSnapshot> documents = snapshot.data!.docs;
               return ListView.builder(
               itemCount:documents.length,
               itemBuilder: (context,int index){
              //return Text( documents[index]['title']);
             //     return Column(
             //       children: [
             //        Text(documents [index]['username']),
             //         Text(documents [index]['describtin']),
             //         Text(documents [index]['title'])
             //
             //       ],
             //     );
                 return Customcard(
                     snapshot:documents[index],
                     index: index,
                    ondelete:()async{
                       await firestoreCollection.doc(documents[index].id).delete();
                    }
                 );
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
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max, // Fit dialog to content size
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
                TextField(
                  decoration: InputDecoration(
                    labelText:"Describtion"

                  ),
                  controller:decrInputcontroller ,
                )
              ],
            ),
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
                    tittleInputcontroller!.text.isNotEmpty &&
                    decrInputcontroller!.text.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('fboard').add({
                    'username': nameInputcontroller!.text,
                    'title': tittleInputcontroller!.text,
                    'describtin': decrInputcontroller!.text,
                    'timestamp': Timestamp.now(),
                  }).then((response) {
                    print("Document ID: ${response.id}");
                    Navigator.of(context).pop();
                    nameInputcontroller!.clear();
                    tittleInputcontroller!.clear();
                    decrInputcontroller!.clear();
                  }).catchError((error) {
                    print("Error saving data: $error");
                  });
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



