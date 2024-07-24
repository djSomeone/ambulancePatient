import 'package:ambulance_test/screens/HomePage/google_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../HomePage/controller/position_controller.dart';
import '../searchDriver/controller/ride_controller.dart';

class CancelledSuccessScreen extends StatelessWidget {
  CancelledSuccessScreen() {
    Future.delayed(Duration(seconds: 1), () {
      Get.find<RideController>().reinitializeController();
      Get.find<PositionController>().reinitializeController();
      Get.to(MapScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 90, child: SvgPicture.asset("asset/cancelledIcon.svg")),
            SizedBox(
                width: 250,
                child: Text(
                  "Your Ride is Successfully Canceled",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    ));
  }
}
