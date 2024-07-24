import 'dart:async';

import 'package:ambulance_test/api/api.dart';
import 'package:ambulance_test/module/loading_shimmer.dart';
import 'package:ambulance_test/screens/ListHospital/controller/pickup_data_controller.dart';
import 'package:ambulance_test/module/loading_card.dart';
import 'package:ambulance_test/screens/ListHospital/modules/location_card.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:shimmer/shimmer.dart';
import '/screens/ListHospital/modules/hospital_card.dart';
import 'package:ambulance_test/screens/ListHospital/controller/list_hospital_controller.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../HomePage/controller/position_controller.dart';
// import 'package:permission_handler/permission_handler.dart';

class LocationSelectionScreen extends StatefulWidget {
  var isDropScreen = true;
  var controller=Get.put(HospitalListController());

  LocationSelectionScreen(
      {required this.isDropScreen});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  var searchController = TextEditingController();
  var pickupController = Get.put(PickupDataController());
  Timer? _debounce;
  // var controller=Get.find<HospitalListController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.getData();
  }

  void _handleTextChanged(String text) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      // Perform your delayed action here with the current text
      pickupController.setData(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(ConstColor.secoundary);

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: standeredAppBar(
              title: widget.isDropScreen
                  ? "Select Drop Location"
                  : "Select Pickup Location"),
          body: Column(
            children: [
              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 10,
                    // color: Colors.grey,
                    child: TextFormField(
                        onChanged: widget.isDropScreen
                            ? (x) {
                                widget.controller.filterData(x.toString());
                              }
                            : _handleTextChanged,
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        cursorColor: ConstColor.primery,
                        decoration: InputDecoration(
                          fillColor: Colors.white70,
                          enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 3)),
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //     borderSide: BorderSide(
                          //         color: Colors.transparent, width: 3)),
                          hintText: widget.isDropScreen
                              ? "Search Hospital"
                              : "Search Location",
                          hintStyle: TextStyle(fontSize: 14),
                          prefixIcon: Icon(
                            Icons.search,
                            color: ConstColor.primery,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ConstColor.grey, width: 2),
                            borderRadius: BorderRadius.circular(20.0),
      
                            // Set your desired corner radius
                          ),
                        )),
                  ),
                ),
              ),
              widget.isDropScreen
                  ? Obx(() => widget.controller.data.value.isEmpty
                      ? Expanded(
                          child: Center(
                          child: Text(
                            "Searching...",
                            style: TextStyle(color: ConstColor.DarkGrey),
                          ),
                        ))
                      : Expanded(
                          child: ListView.builder(
                          itemBuilder: (context, index) {
                            Print.p("in the builder index=$index");
                            var x = widget.controller.searchedHospitalData.value;
                            var y = widget.controller.filteredData.value;
                            // controller.getData();
                            return widget.controller.isFilteredDataEmpty.value ==
                                    true
                                ? HospitalCard(
                                    hname: widget.controller.searchedHospitalData
                                        .value[index]["name"],
                                    hadd: widget.controller.searchedHospitalData
                                        .value[index]["address"],
                                    location: LatLng(x[index]["location"]["lat"],
                                        x[index]["location"]["lng"]),
                                  )
                                : HospitalCard(
                                    hadd: widget.controller.filteredData
                                        .value[index]["address"],
                                    hname: widget.controller.filteredData
                                        .value[index]["name"],
                                    location: LatLng(y[index]["latitude"],
                                        y[index]["longitude"]),
                                  );
                          },
                          itemCount: widget.controller.isFilteredDataEmpty.value
                              ? widget
                                  .controller.searchedHospitalData.value.length
                              : widget.controller.filteredData.value.length,
                        )))
                  :
                  // this is for the pickup location
                  Obx(
                      () => pickupController.data.value.length == 0
                          ? Expanded(
                              child: pickupController.isLoading.value
                                  ? LoadingShimmer()
                                  : Center(
                                      child: Text("Empty"),
                                    ))
                          : Expanded(
                              child: SizedBox(
                              height: 300,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  var data = pickupController.data.value;
                                  return LocationCard(
                                    locationName: data[index]["name"],
                                    locationAdd: data[index]["address"],
                                    latLogn: LatLng(
                                        data[index]["location"]["lat"],
                                        data[index]["location"]["lng"]),
                                  );
                                },
                                itemCount: pickupController.data.length,
                              ),
                            )
      
                              // Placeholder()
                              ),
                    )
            ],
          )),
    );
  }
}
