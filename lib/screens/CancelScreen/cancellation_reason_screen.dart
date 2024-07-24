import 'package:ambulance_test/screens/CancelScreen/cancelledSuccessScreen.dart';
import 'package:ambulance_test/screens/CancelScreen/module/list_tile.dart';
import 'package:ambulance_test/screens/searchDriver/controller/ride_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import '../../utility/constants.dart';
import 'controller/list_tile_controller.dart';

class CancellationReasonScreen extends StatelessWidget {
   CancellationReasonScreen({super.key});
  var controller=Get.put(ListTileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standeredAppBar(title: "Cancellation Reason"),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:20),
        child: Column(
          children: [
            Expanded(flex:2,child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Please select the reason for cancellation",style: TextStyle(fontSize: 20),),
              ],
            )),
            Expanded(flex:5,child: SingleChildScrollView(
              child: SizedBox(
                height: ScreenSize.h*0.7,
                child: Obx(
                ()=> Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CancelListTile(value: "No Longer Needed",title: "No Longer Needed",),
                      CancelListTile(value: "Can't contact the driver",title: "Can't contact the driver",),
                      CancelListTile(value: "Delay in Arrival:",title: "Delay in Arrival:",),
                      CancelListTile(value: "Alternative Transport Arranged",title: "Alternative Transport Arranged",),
                      CancelListTile(value: "Incorrect Address",title: "Incorrect Address",),
                      CancelListTile(value: "Other",title: "Other",),
                      controller.feedBackValue.value=="Other"?Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          onChanged: (x){
                            controller.setOtherReason(x);
                          },
                            minLines: 3,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              hintText: "Write review",

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ConstColor.primery,width: 2),
                                borderRadius: BorderRadius.circular(10.0),


                                // Set your desired corner radius
                              ),
                            )
                        ),
                      ):Text("")
                    ],
                  ),
                ),
              ),
            )),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(


                          style:ElevatedButton.styleFrom(backgroundColor:ConstColor.secoundary,
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), // Set your desired radius
                            ), ),

                          onPressed: ()async{
                            var rideCon=Get.find<RideController>();
                            try{
                            if (controller.feedBackValue.value == "Other") {
                              await Api.sendCancelReason(
                                  rideCon.requestData.value["requestId"]
                                      .toString(),
                                  controller.otherReason.value);
                            } else {
                              await Api.sendCancelReason(
                                  rideCon.requestData.value["requestId"]
                                      .toString(),
                                  controller.feedBackValue.value);
                            }
                            Get.off(CancelledSuccessScreen());
                          }catch(x){
                              toast(msg: "there is some issue while sending your reason");
                            }

                          }, child: Center(child: Text("Confirm",style: TextStyle(color: Colors.white),),)),
                    )
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }
}
