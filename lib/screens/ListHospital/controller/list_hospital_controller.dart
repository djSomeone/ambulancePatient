import 'dart:ffi';
import 'dart:math';

import 'package:ambulance_test/api/api.dart';
import 'package:ambulance_test/screens/HomePage/controller/position_controller.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
// import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HospitalListController extends GetxController
{


  RxList data=[].obs;
  RxList filteredData=[].obs;
  RxBool isFilteredDataEmpty=false.obs;
  RxList searchedHospitalData=[].obs;

  // RxList latLogList=[].obs;

  // this is for the location search pickup
  BitmapDescriptor hosIcon = BitmapDescriptor.defaultMarker;
  void setCustomIcon()
  {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "asset/hospitalIcon.png")
        .then((icon) {
      hosIcon = icon;
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getData();
    setCustomIcon();



  }
  // getting nearby data using the current position
  void getData()async{
    // Print.p("Into the getData of the controller");
    // await getPermission();
    var x=Get.find<PositionController>();
    // Print.p(position.toString());
    var res=await Api.getNearBy(location: x.pickUpDetail.value["position"]);
    Print.p(res.toString());
    if(res["body"]!=null)
      {
        data.value=res["body"];
        filteredData.value=res['body'];
      }

    listNearByMarker();

  }
  void clearData()
  {
    data.value=[];
  }

  void filterData(String filterDataInput)
  async{
    try{
      if(filterDataInput.length==0)
        {
          filteredData.value=data.value;
        }
      else{
        filteredData.value=await filter(filterDataInput);
      }

    }
    catch(x){
      Print.p("Exception:${x.toString()}");
    }
  }

  void listNearByMarker()
  {
    Print.p("In the ListNearByMarker() methos in controler");
    List x=[];
    for(int i=0;i<data.value.length;i++){
      x.add(LatLng(double.parse(data.value[i]["latitude"].toString()), double.parse(data.value[i]["longitude"].toString())));
    }

    var nearByMarker=<Marker>{};

    for(int i=0;i<x.length;i++)
    {
      nearByMarker.addIf(true, Marker(infoWindow:InfoWindow(title: "Hospitals"),markerId: MarkerId(Random().nextInt(1000).toString()),icon: hosIcon,position: x[i]));
    }
    var positionCon=Get.find<PositionController>();

    positionCon.marker.value=nearByMarker;
    positionCon.addPickMarker();

  }



  Future<List> filter( String searchString) async{
    isFilteredDataEmpty.value=false;
    List fData=data.value.where((hospital) {
      // Lowercase both search string and hospital data for case-insensitive search
      final lowerSearchString = searchString.trim().toLowerCase();
      final lowerHospitalData = hospital.values.join(' ').toLowerCase(); // Combine all values
      // print(lowerHospitalData);
      return lowerHospitalData.contains(lowerSearchString);
    }).toList();
    if(fData.length==0)
      {
        var res=await Api.getSearchedHospitalData(searchString);
        searchedHospitalData.value=res["body"]["hospitals"];
        Print.p(searchedHospitalData.value.toString());
        isFilteredDataEmpty.value=true;
        return fData;
      }

      return  fData;


  }
}