// remaining ...
// there is searching screen for the drive
// feedbackScreen fuctionallity
// api integration
// make any element ofthe popup box

// issue
// 1.there is overflow in the cancellationReason Screen in confirm button--solved
// 2.there is some hard code in the homePage where initial camera position latlog is hard coded
// solution:we can dirrectly assign camera position in the googlemap widget and latlog will be assesble from the position
import 'package:ambulance_test/utility/constants.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'api/api.dart';
import 'screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utility/constants.dart';
// 7905222386
var sharedInstance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.transparent, // navigation bar color
  //   statusBarColor: ConstColor.primery, // status bar color
  // ));

  sharedInstance = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSize.h = MediaQuery.of(context).size.height;
    ScreenSize.w = MediaQuery.of(context).size.width;
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
