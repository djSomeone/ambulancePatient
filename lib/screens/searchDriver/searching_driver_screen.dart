import 'dart:async';

import 'package:ambulance_test/screens/HomePage/controller/position_controller.dart';
import 'package:ambulance_test/screens/ride_confirmation.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class SearchDriverScreen extends StatelessWidget {

  SearchDriverScreen(){
    // Future.delayed(Duration(seconds: 4),(){
    //  Get.to(RideConfirmation());
    // });
  }
  var positionCon=Get.find<PositionController>();
  @override
  Widget build(BuildContext context) {
    // var con=AnimationController(vsync:)
    return Scaffold(
      // backgroundColor: Color(0xFFE8E8E8),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background map (commented out as per request)
          // GoogleMapWidget(),
          GoogleMap(
            mapType: MapType.terrain,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
            target: positionCon.pickUpDetail.value["position"],
            zoom: 14.4746,
          ),),
          Container(height:ScreenSize.h,width:ScreenSize.w,color: ConstColor.grey.withOpacity(0.5)),
          // Animated circle
          Positioned(
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.4),
              ),

            ).animate(
                 // this delay only happens once at the very start
                onPlay: (controller) => controller.repeat()
            ).scale(
              duration: 2000.ms,
              curve: Curves.easeInOut,
              begin: Offset(1, 1),
              end: Offset(1.3, 1.3),
            ).then(
              delay: 200.ms
            ).scale( duration: 2000.ms,
              curve: Curves.easeInOut,
              begin: Offset(1.3, 1.3),
              end: Offset(1, 1),),
          ),
          Positioned(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.4),
              ),
            ).animate(
                // this delay only happens once at the very start
                onPlay: (controller) => controller.repeat()
            ).scale(
              duration: 2000.ms,
              curve: Curves.easeInOut,
              begin: Offset(1, 1),
              end: Offset(1.3, 1.3),
            ).then(
              delay: 200.ms
            ).scale( duration: 2000.ms,
              curve: Curves.easeInOut,
              begin: Offset(1.3, 1.3),
              end: Offset(1, 1),),
          ),
          Positioned(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.4),
              ),
            ).animate(
               // this delay only happens once at the very start
                onPlay: (controller) => controller.repeat()
            ).scale(
              duration: 2000.ms,
              curve: Curves.easeInOut,
              begin: Offset(1, 1),
              end: Offset(1.3, 1.3),
            ).then(
              delay: 200.ms
            ).scale( duration: 2000.ms,
              curve: Curves.easeInOut,
              begin: Offset(1.3, 1.3),
              end: Offset(1, 1),),
          ),
          Image.asset(
            'asset/ambulanceIcon.png', // Make sure to add your image to the assets folder and update the path
            width: 100,
            height: 100,
          ),

          // Bottom text
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Searching for Driver',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
            ),
          ),


        ],
      ),
    );
  }
}
