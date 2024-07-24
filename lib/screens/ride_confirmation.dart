import 'package:ambulance_test/screens/HomePage/google_map_screen.dart';
import 'package:ambulance_test/screens/startRide/drive_live_location_screen.dart';
import 'package:ambulance_test/screens/feeedback/feedback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utility/constants.dart';
import 'HomePage/modules/location_selector_card.dart';

class RideConfirmation extends StatelessWidget {
  String pickupAdd="defult value";
  String dropAdd="defult value";
  String price="0";
  var payMethod=PaymentMethod.payByCash;
  late String payMethodValue;
  RideConfirmation({ this.pickupAdd="defult value",this.dropAdd="defult value",this.price="0",this.payMethod=PaymentMethod.payByCash});

  @override
  Widget build(BuildContext context) {
    // payMethodValue=payMethod==PaymentMethod.payByCash?"Cash":(payMethod==PaymentMethod.debitCard)?"Debit Card":(payMethod==PaymentMethod.wallets)?"Wallete":"UPI";
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex:3,child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    height: 90,
                    child: SvgPicture.asset("asset/done.svg")),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("Your Ride is Confirmed",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                ),
              //
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: ConstColor.DarkGrey )),
                    height: 140,
                    padding: EdgeInsets.all(10),
                    child:
                    // this is the layout division
                   standaredpickupDropCard(pickupLocation: pickupAdd,dropLocation: dropAdd,withoutBox: true)
                  ),
                ),
              Container(
                height: 60,
                decoration:  BoxDecoration(borderRadius: BorderRadius.circular(10),color:Color(0xFFF7F8F9),border: Border.all(color:Color(0xFFF7F8F9))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pay by $payMethodValue",style: TextStyle(color: Colors.black,fontSize: 15),),
                      Text("\u{20B9}${int.parse(price)}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
              )
              //
              ],
            )),
            Expanded(flex:1,child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(


                      style:ElevatedButton.styleFrom(backgroundColor:ConstColor.secoundary,
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), // Set your desired radius
                        ), ),

                      onPressed: (){
                        Get.to(FeedbackScreen());
                      }, child: Center(child: Text("Continue ",style: TextStyle(color: Colors.white),),)),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
