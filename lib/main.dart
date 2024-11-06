import 'package:flutter/material.dart';
import 'package:flutterboardapp/boardapp/boardUi/boardapp.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() {
//   runApp(new MaterialApp(
//     home: Boardapp(),
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensures Firebase is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Boardapp(),
    );
  }
}

