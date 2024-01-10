import 'dart:async';
import 'package:cares_task/core/features/crud/crud_controller.dart';
import 'package:cares_task/core/features/nav/home/home_screen.dart';
import 'package:cares_task/core/features/nav/nav_screen.dart';
import 'package:cares_task/core/utils/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    checkAuthState();

    super.initState();
  }

void checkAuthState() async {

  Timer(const Duration(seconds: 3), () {

    Get.offAll(() => const NavScreen());
  });

}



@override
  Widget build(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor:colorScheme.surfaceVariant,
        body:Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  height:300,
                  child: Lottie.asset("assets/animation/tracking.json")
              ),
              Text("Task-Management Apps",style: TextStyle(fontSize: 18,color: HexColor('#855EA9'),fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}

