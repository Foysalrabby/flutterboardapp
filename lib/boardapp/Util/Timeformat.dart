import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeFormat {
  static String formatTimestamp(Timestamp timestamp){
    DateTime dateTime=timestamp.toDate();
    return DateFormat('yyy-MM-dd HH:mm').format(dateTime);
    //return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}

