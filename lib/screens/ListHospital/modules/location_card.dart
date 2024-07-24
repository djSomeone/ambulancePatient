import 'package:ambulance_test/screens/HomePage/controller/position_controller.dart';
import 'package:ambulance_test/screens/ListHospital/controller/pickup_data_controller.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationCard extends StatelessWidget {
  var locationName;
  var locationAdd;
  LatLng latLogn;
   LocationCard({required this.locationName,required this.locationAdd,required this.latLogn});
   var controller=Get.find<PositionController>();

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        controller.setPikupDetail({"add":locationAdd.toString(),"position":latLogn});
        Get.back();

      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: ConstColor.DarkGrey)),
          height: 100,width: ScreenSize.w,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.location_pin,color: ConstColor.secoundary,size: 30,),
            ),
            Expanded(child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(locationName.toString(),maxLines:1,style: TextStyle(fontSize:16,fontWeight:FontWeight.w600,overflow: TextOverflow.ellipsis),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(locationAdd.toString(),maxLines:2,style: TextStyle(fontSize:14,fontWeight:FontWeight.w400,overflow: TextOverflow.ellipsis),),
              ),
            ],)
            )
          ],)),
        ),
    );
  }
}
