import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../api/api.dart';
import '../../../utility/constants.dart';
import '../../../utility/directionPoint/directions_model.dart';
import '../../searchDriver/controller/ride_controller.dart';

class TrackingController extends GetxController{
  Rx<LatLng> driverPosition = LatLng(12.1212124, 17.24347235).obs;
  RxSet<Polyline> polyline = <Polyline>{}.obs;
  RxBool isOtpVerified=false.obs;
   Directions? result;
  var reqData=Get.find<RideController>().requestData.value;
  @override
  void onInit() {
    // TODO: implement onInit
    setDrirection(origin: driverPosition.value, dest: LatLng(reqData["pickupLocation"]["latitude"], reqData["pickupLocation"]["longitude"]));
  }


  void setDriverPosition(LatLng newPosition){
    driverPosition.value=newPosition;
  }


  Future<void> setDrirection(
      {required LatLng origin, required LatLng dest, bool isgoignToDropLocation=false}) async {
    Print.p("in setDrirection()");
    Directions? result =
    await Api.getDirections(origin: origin, destination: dest);
    this.result=result;
    if (result != null) {
      polyline.value = <Polyline>{};
      var updatedRoute = <Polyline>{
        Polyline(
          jointType: JointType.round,
          polylineId: const PolylineId('overview_polyline'),
          color: isgoignToDropLocation?ConstColor.primery:Color(0xFF36A83B),
          width: 4,
          points: result.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        )
      };
      polyline.value = updatedRoute;
    } else {
      toast(msg: "Can't found Direction");
    }
  }
}