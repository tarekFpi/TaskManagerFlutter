
import 'dart:async';
import 'package:cares_task/core/features/crud/insert_screen.dart';
import 'package:cares_task/core/features/crud/model/fatch_response.dart';
import 'package:cares_task/core/features/nav/home/home_screen.dart';
import 'package:cares_task/core/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

 class CrudController extends GetxController with StateMixin<List<FetchResponse>>{

   final tasklist = <FetchResponse>[].obs;


   final databaseRef = FirebaseDatabase.instance.ref('TaskList');

   FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();


   @override
  void onInit() {

     createNotification();

    super.onInit();
  }



   Future insert(String title,String details,String date,String time) async {

     try{

       EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

        databaseRef.child(DateTime.now().microsecondsSinceEpoch.toString()).set({
          "title":title,
          "details":details,
          "date":date,
          "time":time,
        }).then((value) {

          Toast.successToast("Insert SuccessFull..");

          showNotificationAndroid("Insert SuccessFull..", title);

          EasyLoading.dismiss();

        }).onError((error, stackTrace) {

          Toast.errorToast("Insert Failed..$error");
          EasyLoading.dismiss();
          debugPrint("Insert Failed..$error");
        });

     }catch(e){
       EasyLoading.dismiss();
       Toast.errorToast(e.toString());
     }
 }


   Future updateTask(String title,String details,String date,String time,String id) async {

     try{

       EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

       databaseRef.child(id).update({
         "title":title,
         "details":details,
         "date":date,
         "time":time,
       }).then((value){

         Toast.successToast("Update SuccessFull..");

         showNotificationAndroid("Update SuccessFull..", title);

         EasyLoading.dismiss();
       }).onError((error, stackTrace) {

         Toast.errorToast("Update Failed..$error");
         EasyLoading.dismiss();
         debugPrint("$error");
       });

     }catch(e){
       EasyLoading.dismiss();
       Toast.errorToast(e.toString());
     }
   }


   Future<void> delete(String id) async {

     try{

       EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

       FirebaseDatabase.instance.reference().child("TaskList").child(id).remove().then((value) {

         Toast.successToast("Delete SuccessFull..");

         showNotificationAndroid("Delete SuccessFull..", "SuccessFull");

         fetchTask();

         EasyLoading.dismiss();

       },).onError((error, stackTrace) {

         Toast.successToast("$error");
         EasyLoading.dismiss();
       });


     }catch(e){
       EasyLoading.dismiss();
       Toast.errorToast(e.toString());
     }
   }


   Future fetchTask() async {


     change(null, status: RxStatus.loading());

     try{

       FirebaseDatabase.instance.reference().child("TaskList").onValue.listen((needsSnapshot) {

         tasklist.clear();
         needsSnapshot.snapshot.children.forEach((element) {

           var data = FetchResponse.fromSnapshot(element);
           tasklist.add(data);
         });

         change(tasklist, status: RxStatus.success());

       });


     }catch(e){

       Toast.errorToast(e.toString());

       debugPrint(e.toString());

       change(null, status: RxStatus.error(e.toString()));
     }
   }

   void filterTask(String? query) {

     change(null, status: RxStatus.loading());

     if (query == null || query.isEmpty) {

       change(tasklist.value, status: RxStatus.success());

     }else{

       try{

         final list = tasklist.value
             .where((element) =>
             element.title!
                 .toLowerCase()
                 .contains(query!.toLowerCase().trim())
         ).toList();



         if(list.isEmpty){

           change([], status: RxStatus.empty());

         }else {
           change(list, status: RxStatus.success());
         }

       }catch(e){

         debugPrint(e.toString());
       }
     }

   }


   void createNotification(){

     AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

     InitializationSettings initializationSettings = InitializationSettings(
       android: androidSettings,

     );

     notificationsPlugin.initialize(
       initializationSettings,
     );
   }

   void showNotificationAndroid(String title, String body) async {
     const AndroidNotificationDetails androidNotificationDetails =
     AndroidNotificationDetails('channel_id', 'Channel Name',
         channelDescription: 'Channel Description',
         importance: Importance.max,
         priority: Priority.high,
         ticker: 'ticker');

     int notification_id = 1;
     const NotificationDetails notificationDetails =
     NotificationDetails(android: androidNotificationDetails);

     await notificationsPlugin
         .show(notification_id, title, body, notificationDetails, payload: 'Not present');
   }



 }