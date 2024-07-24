import 'package:ambulance_test/screens/MyBookingsPage/controller/my_booking_controller.dart';
import 'package:ambulance_test/screens/MyBookingsPage/modules/complete_card.dart';
import 'package:ambulance_test/screens/MyBookingsPage/modules/ongoing_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utility/constants.dart';
import 'modules/canceled_card.dart';

class MyBookingsScreen extends StatefulWidget {
  MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  var  controller=Get.put(MyBookingController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.changePageIndex(0);
  }

  @override
  Widget build(BuildContext context) {

    // var txtStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    return Scaffold(
      backgroundColor: ConstColor.grey,
      appBar: standeredAppBar(title: "My Bookings"),
      body: Column(
        children: [
          Obx(
            () => SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                            decoration: BoxDecoration(
                                border: controller.pageIndex == 0
                                    ? Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: ConstColor.primery))
                                    : Border.all(color: Colors.transparent)),
                            child: Center(
                              child: Text(
                                "Ongoing",
                                style: TextStyle(color:controller.pageIndex == 0?Colors.black:Color(0xFFA8A8A8),fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                            decoration: BoxDecoration(
                                border: controller.pageIndex == 1
                                    ? Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: ConstColor.primery))
                                    : Border.all(color: Colors.transparent)),
                            child: Center(
                              child: Text(
                                "Completed",
                                style: TextStyle(color:controller.pageIndex == 1?Colors.black:Color(0xFFA8A8A8),fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            decoration: BoxDecoration(
                                border: controller.pageIndex == 2
                                    ? Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: ConstColor.primery))
                                    : Border.all(color: Colors.transparent)),
                            child: Center(
                              child: Text(
                                "Canceled",
                                style: TextStyle(color:controller.pageIndex == 2?Colors.black:Color(0xFFA8A8A8),fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // this is page view
          Obx(
            ()=> Expanded(
              child: PageView(
                onPageChanged: (x) {
                  controller.changePageIndex(x);
                  Print.p(x.toString());
                },
                children: [
                  // ongoingCard
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: controller.ongingData.value.length!=0?ListView.builder(
                      itemBuilder: (context, index) {
                        var x=controller.ongingData
                            .value[index];
                        return OngoingCard(driverName: x["driverName"]??"Not Fund",
                            reqId: x["requestId"],
                            pickLocation: x["pickupAddress"],
                            dropLocation: x["dropAddress"],
                            amount: x["fare"].toString(),
                            distance: x["distance"].toString(),
                            date: x["date"],
                            time: x["time"]);
                      },
                      itemCount: controller.ongingData.value.length,
                    ):Center(child: Text("Empty"),),
                  ),
                  // completedCard
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: controller.completedData.value.length!=0?ListView.builder(
                      itemBuilder: (context, index) {
                        var x=controller.completedData
                            .value[index];
                        return CompleteCard(borderRadius:BorderRadius.circular(4),driverName: x["driverName"],
                            reqId: x["requestId"],
                            pickLocation: x["pickupAddress"],
                            dropLocation: x["dropAddress"],
                            amount: x["fare"].toString(),
                            distance: x["distance"].toString(),
                            date: x["date"],
                            time: x["time"]);
                      },
                      itemCount: controller.completedData.value.length,
                    ):Center(child: Text("Empty"),),
                  ),
                  // Center(
                  //   child: Text("Ongoing",style: txtStyle,),
                  // ),
                  // CancelledData
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:controller.cancelledData.value.length!=0?ListView.builder(
                      itemBuilder: (context, index) {
                        var x=controller.cancelledData
                            .value[index];
                        return CanceledCard(driverName: x["driverName"]??"Not Found",
                            reqId: x["requestId"],
                            pickLocation: x["pickupAddress"],
                            dropLocation: x["dropAddress"],
                            amount: x["fare"].toString(),
                            distance: x["distance"].toString(),
                            date: x["date"],
                            time: x["time"]);
                      },
                      itemCount: controller.cancelledData.value.length,
                    ):Center(child: Text("Empty"),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
