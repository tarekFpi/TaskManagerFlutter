import 'package:cares_task/core/features/auth/login_screen.dart';
import 'package:cares_task/core/features/home/home_screen.dart';
import 'package:cares_task/core/features/home/model/course_response.dart';
import 'package:cares_task/core/network/dio_client.dart';
import 'package:cares_task/core/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController with StateMixin<List<Products>>{

  final dioClient = DioClient.instance;

  final courselist = <Products>[].obs;

  final storage = GetStorage();

  @override
  void onInit() {

    showCourseList();
  }

  Future<void> showCourseList() async{

    try {

      change(null, status: RxStatus.loading());

      final res = await dioClient.get("/products");

      final course_response = CourseResponse.fromJson(res);


        final list = course_response.products ?? [];

        if(courselist.isEmpty){

          change(null, status: RxStatus.empty());
        }

        courselist.assignAll(list);

       change(courselist, status: RxStatus.success());

    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }


  void filterUserList(String? query) {

    if (query == null || query.isEmpty) {

      change(courselist.value, status: RxStatus.success());

    }else{

      try {

        final list = courselist.value
            .where((element) =>
            element.title!
                .toLowerCase()
                .contains(query!.toLowerCase().trim()))
            .toList();

        if (list.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(list, status: RxStatus.success());
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

}