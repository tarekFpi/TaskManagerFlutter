
import 'package:cares_task/core/features/auth/login_screen.dart';
import 'package:cares_task/core/features/home/home_screen.dart';
import 'package:cares_task/core/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

 class AuthController extends GetxController{

   final storage = GetStorage();

   final auth =FirebaseAuth.instance;

   void loginUser(String email,String password) async {

     try{

       EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

        auth.signInWithEmailAndPassword(email: email.toString(),
           password: password.toString()).then((value){

         Toast.successToast("Login SuccessFull..");
         EasyLoading.dismiss();

         saveToken(email, password);

         Get.off(HomeScreen());

       }).onError((error, stackTrace) {
         EasyLoading.dismiss();
         Toast.errorToast("Login Failed..${error}");

         debugPrint("Login Failed..${error}");

       });


     }catch(e){
       EasyLoading.dismiss();
       Toast.errorToast(e.toString());
     }
   }


   void singUpUser(String email,String password) async {

     try{

       EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

        auth.createUserWithEmailAndPassword(email: email.toString(), password: password.toString()).then((value){

         Toast.successToast("Register SuccessFull..");
         EasyLoading.dismiss();

       }).onError((error, stackTrace) {
          EasyLoading.dismiss();
         Toast.errorToast("Register Failed..${error}");

         debugPrint("Register Failed..${error}");

       });


     }catch(e){
       EasyLoading.dismiss();
       Toast.errorToast(e.toString());
     }
   }

    void saveToken(email,password){

      storage.write("email",email);
      storage.write("password",password);
    }


    void logout() async {
      try{

        EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

        Toast.successToast("LogOut Successfully");
        auth.signOut();

        Get.offAll(() => const LoginScreen());

        EasyLoading.dismiss();

      }catch(e){
        EasyLoading.dismiss();
        Toast.errorToast(e.toString());
      }
    }


 }