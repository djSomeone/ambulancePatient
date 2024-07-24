import 'package:ambulance_test/screens/ListHospital/location_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';
import '../screens/HomePage/modules/location_selector_card.dart';

class ButtonController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Print.p("init ButtonController");
  }
  final isLoading = false.obs; // Observable boolean for button state

  void handleClick(dynamic onPressed) async {
    isLoading.value = true; // Show loading state
    await onPressed(); // Execute provided function
    isLoading.value = false; // Reset button state
  }
}

class TextSize {
  static var headingFontSize = 24.0;
}

class ConstColor {
  static var red = Colors.red;
  static var primery = Color(0xFFF29313);
  // static var primery=Color(0xFFF80000);
  static var secoundary = Color(0xFFD96D1F);
  static var grey = Color(0xFFFDFDFD);
  static var DarkGrey = Color(0xFFD2D2D2);

  static var yellow = Color(0xFFF6C41E);
  // static
}

class ScreenSize {
  // becuse to get the current size we need context because of that i had initialized with 0 and when we load first screen on that
  // time we raassigned it with screen orignal size
  static var h = 0.0;
  static var w = 0.0;
}

class ConstBorder {
  static var bDeco =
      BoxDecoration(border: Border.all(color: Colors.red, width: 5));
}

class Print {
  static void p(String x) {
    debugPrint("======================$x====================");
  }
}

class ConstIcon {
  static var backIcon = Icon(
    Icons.arrow_back_ios_new_rounded,
    color: Colors.white,
  );
}

// loop runs until and unless you grant the permission
Future<void> getPermission() async {
  while (!await Permission.location.isGranted) {
    await Permission.location.request();
  }
  Print.p("Location Permission Grandted");
}

// diffrent payment methods
enum PaymentMethod { payByCash, online }

Future<void> toast({required msg}) async {
  await Fluttertoast.showToast(
      msg: msg, backgroundColor: Colors.grey, textColor: Colors.black);
}

AppBar standeredAppBar({required String title,bool backButton=true}) {
  return AppBar(
    leading: backButton?IconButton(
      icon: ConstIcon.backIcon,
      onPressed: () {
        Get.back();
      },
      color: Colors.white,
    ):SizedBox(),
    title: Text(
      title,
      style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.w700),
    ),
    centerTitle: true,
    backgroundColor: ConstColor.secoundary,
  );
}

Widget standardButton({
  required String title,
  required dynamic onPressed,
}) {
  final controller = Get.put(ButtonController()); // Get the controller instance

  return Obx(
        () => SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.isLoading.value
              ? Colors.grey
              : ConstColor.secoundary, // Dynamic color based on state
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: controller.isLoading.value?(){toast(msg: "Loading...");}:() => controller.handleClick(onPressed), // Use controller method
        child: Center(
          child: controller.isLoading.value
              ? SizedBox(height:15,width: 15,child: CircularProgressIndicator(color:ConstColor.DarkGrey,strokeWidth: 2,)) // Show progress indicator
              : Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}


Widget standaredpickupDropCard(
    {pickupLocation =
        "Neelyog Bldg, Shah Bahadur Nagar, RajavNeelyog Bldg, Shah Bahadur Nagar, Rajav",
    dropLocation =
        "Neelyog Bldg, Shah Bahadur Nagar, RajavNeelyog Bldg, Shah Bahadur Nagar, Rajav",
    isPickupClickable=false,
      isDropLocationClickable=false,
      withoutBox=false,
      isOneLine=false
    }) {
  return Material(
    borderRadius: withoutBox?null:BorderRadius.circular(10),
    elevation: withoutBox?0.0:10,
    child: Container(
      height: withoutBox?null:125,
      width: ScreenSize.w,
      color: withoutBox?Color(0xFFFDFDFD):null,
      padding: withoutBox?EdgeInsets.zero:EdgeInsets.symmetric(vertical: 20),
      decoration: withoutBox?null:BoxDecoration(
          color: Color(0xFFFDFDFD), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          // pickup and drop location icons rep
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.green,
                        )),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.lens,
                                size: 4,
                              )),
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.lens,
                                size: 4,
                              )),
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.lens,
                                size: 4,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.location_pin,
                          color: ConstColor.secoundary,
                        )),
                  ],
                ),
              )),
          // pick uo drop feildes
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: LocationSelectorCard(
                          title: withoutBox?"":"Pickup Location",
                          value: pickupLocation,
                          maxline: withoutBox?isOneLine?1:2:1,
                          titleColor: Colors.green,
                          onTap: isPickupClickable?() async {
                            Get.to(LocationSelectionScreen(isDropScreen: false));
                          }:(){})),
                  withoutBox?SizedBox(height: 10,):Divider(),
                  Expanded(
                      child: LocationSelectorCard(
                    title: withoutBox?"":"Drop Location",
                    value: dropLocation,
                    maxline: withoutBox?isOneLine?1:2:1,
                    titleColor: ConstColor.primery,
                    onTap: isDropLocationClickable?() async {
                      Get.to(LocationSelectionScreen(isDropScreen: true));
                    }:(){},
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget standaredAlertBox(
    {required title,
    required subTitle,
    required firstButtonColor,
    required secoundButtonColor,
    required onTapFirstButton,
    required onTapSecoundButton,
    required textFirstButton,
      firstTextColor=Colors.black,
      secoundTextColor=Colors.white,
    required textSecoundButton}) {
  return AlertDialog(
    title: Text(title),
    content: Text(subTitle),
    actions: [
      GestureDetector(
        onTap: onTapFirstButton,
        child: Container(
          decoration: BoxDecoration(
              color: firstButtonColor, borderRadius: BorderRadius.circular(6)),
          height: 40,
          width: 100,
          child: Center(
            child: Text(
              textFirstButton,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: onTapSecoundButton,
        child: Container(
          decoration: BoxDecoration(
              color: secoundButtonColor,
              borderRadius: BorderRadius.circular(6)),
          height: 40,
          width: 100,
          child: Center(
            child: Text(
              textSecoundButton,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ),
    ],
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  );
}

void removeUserData() async {
  await sharedInstance.remove("userName");
  await sharedInstance.remove("number");
  await sharedInstance.remove("cardDetails");
  Print.p("removed user data successfully");
}

void localizeUserData(String number, String name) async {
  await sharedInstance.setString("userName", name);
  await sharedInstance.setString("number", number);
  Print.p("added user data successfully");
}
