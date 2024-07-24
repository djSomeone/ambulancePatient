import 'package:ambulance_test/module/rating_start/rating_star.dart';
import 'package:ambulance_test/screens/HomePage/controller/position_controller.dart';
import 'package:ambulance_test/screens/HomePage/google_map_screen.dart';
import 'package:ambulance_test/screens/feeedback/controller/feedback_controller.dart';
import 'package:ambulance_test/screens/ride_confirmation.dart';
import 'package:ambulance_test/screens/searchDriver/controller/ride_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import '../../utility/constants.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});
  ScrollController scrollController = ScrollController();
  var controller = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: standeredAppBar(title: "Share Feedback",backButton: false),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            controller: scrollController,
            child: SizedBox(
              height: ScreenSize.h * 0.8,
              child: Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(26.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Your Ride is Successfully Completed",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Text(
                                    "Rate the driver",
                                    style: TextStyle(
                                        color: Color(0xFF777B80), fontSize: 14),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Obx(() => StarDisplay(
                                          value: controller.rating.value,
                                          size: 40,
                                          color: ConstColor.secoundary,
                                          isClickable: true,
                                        )),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      "Leave a Feedback",
                                      style:
                                          TextStyle(color: Color(0xFF3E4958)),
                                    ),
                                  ),
                                  Expanded(
                                      child: Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller
                                                .setFeedBackValue("Punctual");
                                          },
                                          child: Container(
                                            height: 70,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: controller
                                                                .feedBackValue
                                                                .value ==
                                                            "Punctual"
                                                        ? ConstColor.primery
                                                        : Color(0xFFD9D9D9))),
                                            child: Center(
                                              child: Text(
                                                "Punctual",
                                                style: TextStyle(
                                                    color: controller
                                                                .feedBackValue
                                                                .value ==
                                                            "Punctual"
                                                        ? ConstColor.primery
                                                        : Color(0xFF777B80)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.setFeedBackValue(
                                                "Professional");
                                          },
                                          child: Container(
                                            height: 70,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: controller
                                                                .feedBackValue
                                                                .value ==
                                                            "Professional"
                                                        ? ConstColor.primery
                                                        : Color(0xFFD9D9D9))),
                                            child: Center(
                                              child: Text(
                                                "Professional",
                                                style: TextStyle(
                                                    color: controller
                                                                .feedBackValue
                                                                .value ==
                                                            "Professional"
                                                        ? ConstColor.primery
                                                        : Color(0xFF777B80)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      child: Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller
                                                .setFeedBackValue("Efficient");
                                          },
                                          child: Container(
                                            height: 70,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: controller
                                                                .feedBackValue
                                                                .value ==
                                                            "Efficient"
                                                        ? ConstColor.primery
                                                        : Color(0xFFD9D9D9))),
                                            child: Center(
                                              child: Text(
                                                "Efficient",
                                                style: TextStyle(
                                                    color: controller
                                                                .feedBackValue
                                                                .value ==
                                                            "Efficient"
                                                        ? ConstColor.primery
                                                        : Color(0xFF777B80)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller
                                                .setFeedBackValue("Others");
                                          },
                                          child: Container(
                                            height: 70,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: controller
                                                                .feedBackValue
                                                                .value ==
                                                            "Others"
                                                        ? ConstColor.primery
                                                        : Color(0xFFD9D9D9))),
                                            child: Center(
                                              child: Text(
                                                "Others",
                                                style: TextStyle(
                                                    color: controller
                                                                .feedBackValue
                                                                .value ==
                                                            "Others"
                                                        ? ConstColor.primery
                                                        : Color(0xFF777B80)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              )),
                          Expanded(
                              flex: 2,
                              child: Obx(
                                () => controller.feedBackValue.value == "Others"
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 14),
                                        child: TextFormField(
                                            onTap: () {
                                              scrollController.animateTo(
                                                scrollController
                                                    .position.maxScrollExtent,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            },
                                            minLines: 3,
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              hintText: "Write review",
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: ConstColor.primery,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),

                                                // Set your desired corner radius
                                              ),
                                            )),
                                      )
                                    : Text(""),
                              )),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          standardButton(
                                title: "Confirm",
                                onPressed: onPress),

                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
  Future<void> onPress() async {
    var con = Get.find<RideController>();
    var reqData = con.requestData.value;
    try{
      if (controller.feedBackValue.value ==
          "Others") {
        await Api.sendfeedBack(
            reqData["requestId"].toString(),
            reqData["driverPhoneNumber"].toString(),
            controller.rating.value.toString(),
            controller.otherFeedBack.value
                .toString());
      } else {
        await Api.sendfeedBack(
            reqData["requestId"].toString(),
            reqData["driverPhoneNumber"].toString(),
            controller.rating.value.toString(),
            controller.feedBackValue.value
                .toString());
      }
      Print.p("afteer sending feedback");
      Get.find<RideController>().reinitializeController();
      //
      Get.find<PositionController>().reinitializeController();
      Get.to(MapScreen());
    }catch(x)
    {
      toast(msg: "there is some issuse2423423");
    }
  }

}
