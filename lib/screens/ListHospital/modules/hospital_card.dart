import 'package:ambulance_test/screens/HomePage/controller/position_controller.dart';
import 'package:ambulance_test/screens/OrderSummary/order_summary.dart';
import 'package:ambulance_test/screens/searchDriver/searching_driver_screen.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// this is the card view of the hospitalDetail
class HospitalCard extends StatelessWidget {
  String hname='defult text';
  String hadd="no address";
  LatLng location=LatLng(10.00, 100.00);


   HospitalCard({required this.hadd,required this.hname,required this.location});
   // this instance is for the updating droplocation
   var positionCon=Get.find<PositionController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Print.p("onclick");
        // Get.to(AmbulanceMap());
        positionCon.setDropDetail({"add":hadd.toString(),"position":location,"hname":hname});
        Get.back();
        // Get.to(OrderSummary(hadd: hadd, hname: hname,));
      },
      child: Container(
        height:100,

        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(),color: ConstColor.grey),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:Row(
            children: [
              Expanded(flex:1,child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:EdgeInsets.only(top:20),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black38,
                      child: Center(child: Icon(Icons.location_on_rounded,color: Colors.white,size: 30,),),
                    ),
                  )
                ],
              )),
              Expanded(flex:4,child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(hname,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)),
                    Expanded(child: Text(hadd,style: TextStyle(fontSize: 16,color: Colors.grey),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                    Divider()

                  ],
                ),
              ))
            ],
          )
        ),
      ),
    );
  }
}
// Row(
// children: [
// Image.asset(distance,fit: BoxFit.cover,height: 60,width: 60,errorBuilder: (context,x,y){
// return Text("not available");
// },),
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisSize: MainAxisSize.max,
// children: [
//
// // decoration: ConstBorder.bDeco,
// SizedBox(width:ScreenSize.w*0.55,child: Text("$hname",style: TextStyle(fontSize: 30),overflow: TextOverflow.ellipsis,maxLines: 1,)),
// Container(height:ScreenSize.h*0.07,width:ScreenSize.w*0.55,child: Text("address:$hadd",overflow: TextOverflow.ellipsis,maxLines: 2,)),
// Expanded(child: Text("Price:$price"))
//
// ],
// ),
// ],
// ),