
import 'package:cares_task/core/features/crud/insert_screen.dart';
import 'package:cares_task/core/features/nav/nav_screen.dart';
import 'package:cares_task/core/features/splash/splash_screen.dart';
import 'package:cares_task/core/theme/app_theme.dart';
import 'package:cares_task/core/utils/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:upgrader/upgrader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app_settings/app_settings.dart';


void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  configLoading();

}


void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..backgroundColor = Colors.white
    ..indicatorColor = HexColor("#855EA9")
    ..textColor = Colors.black
    ..maskColor = Colors.white.withOpacity(0.8);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        themeMode: ThemeMode.light,
        home: SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

