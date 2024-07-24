import 'package:ambulance_test/api/api.dart';
import 'package:ambulance_test/screens/HomePage/controller/position_controller.dart';
import 'package:ambulance_test/screens/OrderSummary/module/paymentTypeTile.dart';
import 'package:ambulance_test/screens/Payment/controller/payment_screen_controller.dart';
import 'package:ambulance_test/screens/Payment/payment_methods_screen.dart';
import 'package:ambulance_test/screens/ride_confirmation.dart';
import 'package:ambulance_test/screens/searchDriver/controller/ride_controller.dart';
import 'package:ambulance_test/screens/searchDriver/searching_driver_screen.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// import '../utility/constants.dart';
// import '';

class OrderSummary extends StatefulWidget {
  var hname = "";
  var hadd = "";
  String price = "";
  var distance = "";
  var pickLocation = "";

  // var paymentMethod=PaymentMethod.payByCash;

  OrderSummary(
      {required this.hadd,
      this.distance = "0",
      this.price = "0",
      required this.hname,
      this.pickLocation = ""});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  late double totalAmount = 0.0;

  var paymentController = Get.put(PaymentScreenController());
  var myPositionController = Get.find<PositionController>();
  // var controller=Get.put();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    paymentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var serviceFee = 0.0;
    if (widget.distance != "null") {
      var distanceInDouble = double.parse(widget.distance);
      var kilometer = distanceInDouble.toInt();
      var meters = distanceInDouble - kilometer;
      serviceFee = (kilometer * 25) + (meters * 0.25);
      totalAmount = double.parse(widget.price) + serviceFee;
    }

    return Scaffold(
      appBar: standeredAppBar(title: "Ride Summary"),
      backgroundColor: Color(0xFFFDFDFD),
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // this is hsp name representation
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 30,
                                child: Image(
                                    image: AssetImage("asset/hsIcon.png"))),

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.hname,
                                      style: TextStyle(fontSize: 16),
                                      maxLines: 1,
                                    ),
                                    Text(
                                      widget.hadd,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // Divider()
                          ],
                        )),
                    Divider(),
                    // fare and distance
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                // decoration: ConstBorder.bDeco,
                                width: 300,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.speed,
                                      color: ConstColor.secoundary,
                                      size: 32,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "\u{20B9}${widget.price}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                    child: Text(
                                  "${widget.distance ?? 0}Km",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )),
                              ),
                            ),
                          ],
                        )),
                    Divider(),
                    // pick add and drop add
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: standaredpickupDropCard(
                              withoutBox: true,
                              pickupLocation: widget.pickLocation,
                              dropLocation: widget.hadd),
                        )),
                    Divider(),
                    // payment summary
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Summary',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          // Spacer(),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Ride Fare"),
                                Text(
                                  "\u{20B9}${widget.price}",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Service Fee"),
                                Text(
                                  "+ \u{20B9}${serviceFee.round()}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),

                          Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            style: TextStyle(fontSize: 22, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Amount",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "\u{20B9}${totalAmount.round()}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                  ],
                ),
              )),
          // button

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // SizedBox(
                //   height: 50,
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: ConstColor.secoundary,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(
                //               10.0), // Set your desired radius
                //         ),
                //       ),
                //       onPressed: onPress,
                //       child: Center(
                //         child: Text(
                //           "Search Ambulance",
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       )),
                // )
                standardButton(title: "Search Ambulance", onPressed: onPress)
              ],
            ),
          )
        ],
      ),
    );
  }

  void handlePaymentErrorResponse() {
    toast(msg: "payment failded");
  }

  void handlePaymentSuccessResponse() {}
  Future<void> onPress() async {
    try {
      // this isfor setting the requestdata
      var tempController = Get.find<RideController>();
      LatLng pickUp = myPositionController
          .pickUpDetail.value["position"];
      LatLng dropLoc = myPositionController
          .droplocationDetail.value["position"];
      // this is for the getting data and setting to the rideControllerData
      var data = await Api.sendRequestForAmbulance(
          pickUp, dropLoc);
      tempController.setRequestData(newData: data["body"]);
      // ///////
      Get.to(SearchDriverScreen());
    } catch (x) {
      await toast(
          msg:
          "there is Some issues\n while sending for ambulance request");
    }
    // Get.to(RideConfirmation(dropAdd: widget.hadd,payMethod: controller.choosedMethod.value,price: totalAmount.toString(),pickupAdd: widget.pickLocation,));
  }
}
