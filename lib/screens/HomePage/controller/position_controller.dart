import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../api/api.dart';
import '../../../utility/directionPoint/directions_model.dart';
import '../../ListHospital/controller/list_hospital_controller.dart';

class PositionController extends GetxController {
  // var mapController;
  // PositionController({this.mapController});
  Rx<LatLng> myPosition = LatLng(12.1212124, 17.24347235).obs;
  RxBool isSelectedDropLocation = false.obs;
  RxBool isSetCurrentPosition = false.obs;
  RxBool isSetDropLocation = false.obs;


  // this for the maintainig the pickup and drop location
  RxMap<String, dynamic> pickUpDetail = {
    "add": "Select Location",
    "position": LatLng(12.1212124, 17.24347235)
  }.obs;
  RxMap<String, dynamic> droplocationDetail = {
    "add": "Select Location",
    "position": LatLng(12.1212124, 17.24347235)
  }.obs;

  // this is for the markers
  RxSet<Marker> marker = <Marker>{}.obs;
  RxSet<Polyline> route=<Polyline>{}.obs;
  RxSet<Circle> area=<Circle>{}.obs;

  // this is for the icosMarkers
  BitmapDescriptor pickMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropMarker = BitmapDescriptor.defaultMarker;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeToCurrentLocation();
    //  for initial location
  }


  Future<void> setCustomIcon() async{
    pickMarker=await BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "asset/pickUplocation.png");

    dropMarker=await BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "asset/hospitalIcon.png");

    Print.p("end of the setCustomicon");
  }

  //////////
void reinitializeController(){
    Print.p("reinitializeController position controller");
    try{
      myPosition.value = LatLng(12.1212124, 17.24347235);

      isSelectedDropLocation.value = false;
      isSetCurrentPosition.value = false;
      isSetDropLocation.value = false;

      // this for the maintainig the pickup and drop location
     resetPickDropLoc();

      // this is for the markers
      marker.value = <Marker>{};
      route.value = <Polyline>{};
      area.value = <Circle>{};

      changeToCurrentLocation();
    }catch(x){
      Print.p("there  is exception in reinitializeController in positionCon");
      Print.p(x.toString());
    }
  }

  // this method is used in reinitialiizetionof the con
  void resetPickDropLoc(){
    pickUpDetail.value["add"]="Select Location";
    pickUpDetail.value["position"]=LatLng(12.1212124, 17.24347235);
    droplocationDetail.value["add"]="Select Location";
    droplocationDetail.value["position"]=LatLng(12.1212124, 17.24347235);


  }




  void addPickMarker() {
    Set<Marker> n = marker.value;
    n.add(Marker(
        markerId: MarkerId("you"),
        icon: pickMarker,
        infoWindow: InfoWindow(title: "Pickup"),
        position: pickUpDetail.value["position"]));
    marker.value = n;
    Print.p("After adding pick marker \n${marker.value}");
  }

  void addDropMarker(LatLng position) {
    Set<Marker> n = marker.value;
    marker.value=<Marker>{};
    n.add(Marker(
        markerId: MarkerId("droplocation"),
        icon: dropMarker,
        infoWindow: InfoWindow(title: "Drop"),
        position: position));
    marker.value=n;
  }

  void setMyPosition(LatLng location) {
    myPosition.value = location;
  }

  void changeToCurrentLocation() async {
    Print.p("in Position ");
    await setCustomIcon();
    Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    isSetCurrentPosition.value = true;
    var x = LatLng(currentLocation.latitude, currentLocation.longitude);
    myPosition.value = x;
    var add = await Api.getHumanReadableAdd(x);
    Print.p(add.toString());
    Print.p("befor put the Get.put(HospitalListController())");
    Get.put(HospitalListController());
    setPikupDetail({"add": add["body"]["address"].toString(), "position": x});

    addPickMarker();

    // Get.find<HospitalListController>().listNearByMarker();
  }

  void setPikupDetail(var newPickUpDetail) {
    pickUpDetail.value = newPickUpDetail;
    addPickMarker();
    if(isSetDropLocation.value){
      setPolylinePoint();
    }
    setAreaInMap();
    Get.find<HospitalListController>().getData();
    Print.p(newPickUpDetail["position"].toString());
  }


  void setDropDetail(var newDropDetail) async{
    droplocationDetail.value = newDropDetail;
    marker.value=<Marker>{};
    addPickMarker();
    addDropMarker(newDropDetail["position"]);
    isSetDropLocation.value=true;
    await setPolylinePoint();
    Print.p(newDropDetail["position"].toString());
  }

  Future<void> setPolylinePoint()
  async{
    Directions? direction=await Api.getDirections(origin: pickUpDetail.value["position"], destination: droplocationDetail.value["position"]);
    if(direction!=null)
      {
        route.value=<Polyline>{};
        var updatedRoute=<Polyline>{
          Polyline(
            jointType: JointType.round,
            polylineId: const PolylineId('overview_polyline'),
            color: ConstColor.primery,
            width: 4,
            points: direction.polylinePoints
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          )
        };
        route.value=updatedRoute;
        // this is for the updating dropLocationDertail
        var t=droplocationDetail.value;
        var addedDetail={"fare":direction.fare,"distance":direction.totalDistance};
        t.addAll(addedDetail);
        droplocationDetail.value=t;

      }
  }

  void setAreaInMap(){

    area.value=<Circle>{
      Circle(
          circleId: CircleId("area"),
          center: pickUpDetail.value["position"],
          strokeColor: ConstColor.DarkGrey,
          radius: 1000,
          strokeWidth: 2,
          fillColor: ConstColor.DarkGrey.withOpacity(0.6))
    };
  }
}



// import 'package:get/get.dart';
//
// class UserPosition extends GetxController{
//   Rx<LatLng> myPosition=LatLng(12.1212124, 17.24347235).obs;
// }
