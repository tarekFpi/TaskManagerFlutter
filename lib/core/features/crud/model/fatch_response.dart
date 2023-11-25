
import 'package:firebase_database/firebase_database.dart';


class FetchResponse {

  String? id;
  String? title;
  String? details;
  String? date;
  String? time;

  FetchResponse({
    this.id,
    this.title,
    this.details,
    this.date,
    this.time,
  });

 FetchResponse.fromSnapshot(DataSnapshot snapshot){
    Map<String, dynamic> myData= Map<String,dynamic>.from(snapshot.value as
    Map);
    id= snapshot.key.toString();
    title = myData["title"].toString() ?? '';
    details =myData["details"].toString() ?? '';
    date = myData["date"].toString() ?? '';
    time = myData["time"].toString() ?? '';
  }



  Map<String,dynamic> toJson() {
    return {
      "title": title,
      "details": details,
      "date": date,
      "time": time,

    };
  }
}


