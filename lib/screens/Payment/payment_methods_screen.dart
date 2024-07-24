import 'package:ambulance_test/screens/Payment/controller/payment_screen_controller.dart';
// import 'package:ambulance_test/module/drop_down/drop_down_controller.dart';
import 'package:ambulance_test/screens/Payment/module/payment_tile.dart';
import 'package:ambulance_test/screens/ride_confirmation.dart';
import 'package:ambulance_test/screens/searchDriver/controller/ride_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../module/drop_down/drop_down.dart';
import '../../utility/constants.dart';

class PaymentMethodsScreen extends StatelessWidget {
  String price = "";
  PaymentMethod payMethod = PaymentMethod.payByCash;
  PaymentMethodsScreen({this.payMethod = PaymentMethod.payByCash});

  var paymentMethodController = Get.put(PaymentScreenController());
  var rideController = Get.find<RideController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      appBar: standeredAppBar(title: "Payment Methods", backButton: false),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  // upi

                  // PaymentTile(method: PaymentMethod.wallets, text: "Wallets"),
                  // DropDown(),
                  // PaymentTile(method: PaymentMethod.debitCard, text: "Debit Cards"),
                  PaymentTile(
                      method: PaymentMethod.payByCash, text: "Pay by Cash"),
                  PaymentTile(method: PaymentMethod.online, text: "Online"),
                ],
              ),
            ),
            Expanded(
                flex: 1,
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
                    //       onPressed: () {
                    //         showDialog(
                    //             context: context,
                    //             builder: (context) {
                    //               return standaredAlertBox(
                    //                   title: paymentMethodController
                    //                               .choosedMethod.value ==
                    //                           PaymentMethod.online
                    //                       ? "Online?"
                    //                       : "Pay by Cash?",
                    //                   subTitle:
                    //                       "Are you sure you want to continue?",
                    //                   firstButtonColor: Color(0xFFDDDDDD),
                    //                   secoundButtonColor: ConstColor.secoundary,
                    //                   onTapFirstButton: () {
                    //                     Get.back();
                    //                   },
                    //                   onTapSecoundButton: onPress,
                    //                   textFirstButton: "No",
                    //                   textSecoundButton: "Yes");
                    //             });
                    //       },
                    //       child: Center(
                    //         child: Text(
                    //           "Confirm ",
                    //           style: TextStyle(color: Colors.white),
                    //         ),
                    //       )),
                    // ),
                    standardButton(title: "Confirm", onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return standaredAlertBox(
                                title: paymentMethodController
                                    .choosedMethod.value ==
                                    PaymentMethod.online
                                    ? "Online?"
                                    : "Pay by Cash?",
                                subTitle:
                                "Are you sure you want to continue?",
                                firstButtonColor: Color(0xFFDDDDDD),
                                secoundButtonColor: ConstColor.secoundary,
                                onTapFirstButton: () {
                                  Get.back();
                                },
                                onTapSecoundButton: onPress,
                                textFirstButton: "No",
                                textSecoundButton: "Yes");
                          });
                    })
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void onPress() async {
    if (paymentMethodController.choosedMethod.value == PaymentMethod.online) {
      toast(msg: "going to razorpay");
      double fare = rideController.requestData.value["fare"] ?? 1;
      int amount = 100 * fare.toInt();
      Print.p(amount.toString());
      // Print.p(fare.runtimeType.toString());
      Razorpay razorpay = Razorpay();
      var options = {
        'key': 'rzp_live_nhxJUEiWdTlmVR',
        'amount': amount,
        'name': 'Synco Ambulances',
        'description': 'Fare charges',
      };
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
      // razorpay.on(Razorpay, handleExternalWalletSelected);
      razorpay.open(options);
    } else {
      Print.p("Else");
      Get.back();
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    toast(msg: "Error");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    toast(msg: "Success");
  //   add event for success paymet
  //   get to feed back
  }
  // void
}
