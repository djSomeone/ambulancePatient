import 'dart:async';
import 'dart:ui';

import 'package:ambulance_test/screens/CancelScreen/cancelledSuccessScreen.dart';
// import 'package:ambulance_test/module/popup.dart';
import 'package:ambulance_test/module/rating_start/rating_star.dart';
import 'package:ambulance_test/screens/CancelScreen/cancellation_reason_screen.dart';
import 'package:ambulance_test/screens/HomePage/google_map_screen.dart';
import 'package:ambulance_test/screens/feeedback/feedback_screen.dart';
import 'package:ambulance_test/screens/searchDriver/controller/ride_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utility/constants.dart';
import '../HomePage/controller/position_controller.dart';
import 'controller/tracking_contrroller.dart';

class DriveLiveLocationScreen extends StatefulWidget {
  const DriveLiveLocationScreen({super.key});

  @override
  State<DriveLiveLocationScreen> createState() =>
      _DriveLiveLocationScreenState();
}

class _DriveLiveLocationScreenState extends State<DriveLiveLocationScreen> {
   GoogleMapController? mapController;
  var rideController = Get.find<RideController>();
  var controller = Get.put(TrackingController());
  late BitmapDescriptor driver = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor dropIcon = BitmapDescriptor.defaultMarker;
  late var reqData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomIcon();
  }

  void setCustomIcon() async {
    driver = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'asset/ambulance.png',
    );
    pickUpIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'asset/p.png',
    );
    dropIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'asset/d.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    var h1txtstyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
    var h2txtstyle = TextStyle(fontSize: 12);
    reqData = rideController.requestData.value;

    return Scaffold(
        appBar: standeredAppBar(title: "Driver Live Location"),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Obx(
                () {
                  if (mapController != null) {
                    mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                      target: controller.driverPosition.value,
                      zoom: 18.4746,
                    )));
                  }
                  return GoogleMap(
                    mapType: MapType.terrain,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: controller.driverPosition.value,
                      zoom: 18.4746,
                    ),
                    polylines: controller.polyline.value,
                    markers: <Marker>{
                      Marker(
                        markerId: MarkerId('Driver'),
                        icon: driver,
                        position: controller.driverPosition.value,
                      ),
                      controller.isOtpVerified.value?
                      Marker(
                        markerId: MarkerId('dropLocation'),
                        icon: dropIcon,
                        infoWindow: InfoWindow(title: "Drop Location"),
                        position: LatLng(reqData["dropLocation"]["latitude"],
                            reqData["dropLocation"]["longitude"]),
                      ):
                      Marker(
                        markerId: MarkerId('pickLocation'),
                        icon: pickUpIcon,
                        infoWindow: InfoWindow(title: "PickUp Location"),
                        position: LatLng(reqData["pickupLocation"]["latitude"],
                            reqData["pickupLocation"]["longitude"]),
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Estimated Arrival",
                                    style: h1txtstyle,
                                  ),
                                  Text(
                                    "02 mins",
                                    style: h1txtstyle,
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: LinearProgressIndicator(
                                  value: 0.8,
                                  color: ConstColor.primery,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  reqData["pickupAddress"].toString(),
                                  style: h2txtstyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                        ],
                      )),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Driver Details",
                              style: h1txtstyle,
                            ),
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blueAccent,
                                      radius: 35,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                        size: 50,
                                      ),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 14),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(reqData["driverName"]
                                                    .toString()),
                                                Text(
                                                  "OTP",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: 100,
                                                  child: StarDisplay(
                                                    value: reqData["rating"]??2,
                                                  )),
                                              Text(
                                                reqData["otp"].toString(),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                                // Expanded(flex:1,child: Placeholder()),
                                                              ],
                                                            )),
                            Text(
                              "Please share the OTP upon arrival of the driver.",
                              style: h2txtstyle,
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => standaredAlertBox(
                                      title: "Cancel Ride?",
                                      subTitle:
                                          "Are you sure want to cancel the ride?",
                                      firstButtonColor: Color(0xFFD74444),
                                      secoundButtonColor: ConstColor.DarkGrey,
                                      onTapFirstButton: () {
                                        rideController.socket
                                            .cancelRideAfterDriverAcceptance(
                                                reqData);

                                        Get.to(CancellationReasonScreen());
                                      },
                                      onTapSecoundButton: () {
                                        Get.back();
                                      },
                                      textFirstButton: "Yes",
                                      textSecoundButton: "No",
                                      firstTextColor: ConstColor.grey,
                                      secoundTextColor: Colors.white));
                            },
                            child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: Center(
                                  child: Text(
                                    'Cancel Ride',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          )),
                          SizedBox(
                            width: 14,
                          ),
                          Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 4,
                              child: GestureDetector(
                                onTap: () async {
                                  final url =
                                      'tel:${reqData["driverPhoneNumber"]}';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Could not launch phone dialer");
                                  }
                                },
                                child: Container(
                                    height: 54,
                                    width: 54,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Icon(
                                        Icons.call,
                                        color: ConstColor.primery,
                                      ),
                                    )),
                              ))
                        ],
                      )),
                  // Expanded(child: Placeholder()),
                ],
              ),
            ))
          ],
        ));
  }
}
