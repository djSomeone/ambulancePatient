import 'package:ambulance_test/screens/HomePage/controller/position_controller.dart';
import 'package:ambulance_test/screens/HomePage/home_page_loading_screen.dart';
import 'package:ambulance_test/screens/HomePage/modules/drawer.dart';
import 'package:ambulance_test/screens/OrderSummary/order_summary.dart';
import 'package:ambulance_test/screens/Payment/payment_methods_screen.dart';
import 'package:ambulance_test/screens/searchDriver/controller/ride_controller.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  var searchController = TextEditingController();
  var yourLocation = TextEditingController();

  var phoneNumber = "+918330901234";

  var myPositionController = Get.put(PositionController());
  // this is use for the rideRequestHandling
  var requestRideController = Get.put(RideController());
  // this is because for the we have to get initially


  @override
  void initState() {
    Print.p("in initState");
    // TODO: implement initState
    super.initState();
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(ConstColor.secoundary);
    return Scaffold(
      key: widget._scaffoldKey,
      drawer: HomeDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            // Placeholder(),
            // this is the pick up and drop top part

            Obx(() {
              // this piece  of code for  the updating camera  position
              if (_controller != null) {
                _controller!.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: myPositionController.pickUpDetail.value["position"],
                  zoom: 15.4746,
                )));
              }
              return myPositionController.isSetCurrentPosition.value
                  ? GoogleMap(
                      onTap: (l) {
                        Print.p(l.latitude.toString());
                        Print.p(l.latitude.toString());
                      },
                      mapType: MapType.terrain,
                      zoomControlsEnabled: false,
                      circles: myPositionController.area.value,
                      markers: myPositionController.marker.value,
                      polylines: myPositionController.route.value,
                      initialCameraPosition: CameraPosition(
                        target:
                            myPositionController.pickUpDetail.value["position"],
                        zoom: 14.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                        // _controller.
                      },
                    )
                  : homePageLoadingScreen();
            }),

            Positioned(
                // top: 10,
                child: SizedBox(
                  height: ScreenSize.h * 0.36,
                  width: ScreenSize.w,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // this  is first yourlocation
                        Material(
                          elevation: 0.7,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              height: 48,
                              width: 48,
                              // width: ScreenSize.w * 0.95,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GestureDetector(
                                  onTap: () {
                                    widget._scaffoldKey.currentState
                                        ?.openDrawer();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.black87,
                                    ),
                                  ))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: Obx(() => Column(
                                  children: [
                                    standaredpickupDropCard(
                                        pickupLocation: myPositionController
                                            .pickUpDetail.value["add"],
                                        dropLocation: myPositionController
                                            .droplocationDetail.value["add"],
                                        isDropLocationClickable: true,
                                        isPickupClickable: true),
                                    myPositionController.isSetDropLocation.value
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Material(
                                              elevation: 5,
                                              borderRadius: BorderRadius.circular(10),
                                              shadowColor: Colors.grey,
                                              child: standardButton(
                                                  title: "Continue",
                                                  onPressed: () {
                                                    Print.p("Clicked me");
                                                    var droplocDetail =
                                                        myPositionController
                                                            .droplocationDetail
                                                            .value;

                                                    Get.to(
                                                      OrderSummary(
                                                        hadd:
                                                            droplocDetail["add"],
                                                        hname: droplocDetail[
                                                            "hname"],
                                                        price:
                                                            droplocDetail["fare"]
                                                                .toString(),
                                                        distance: droplocDetail[
                                                                "distance"]
                                                            .toString(),
                                                        pickLocation:
                                                            myPositionController
                                                                .pickUpDetail
                                                                .value["add"],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          )
                                        : Expanded(child: Center())
                                  ],
                                ))),
                      ],
                    ),
                  ),
                )),
            // Positioned(top:10,child: Placeholder()),
          ],
        ),
      ),
      floatingActionButton: Container(
        // decoration: ConstBorder.bDeco,
        width: ScreenSize.w * 0.9,
        height: 100,
        child: Center(
          child: Container(
            // decoration: ConstBorder.bDeco,
            height: 80,
            width: 80,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.redAccent),
              ),

              onPressed: () async {
                // final url = 'tel:$phoneNumber';
                // if (await canLaunch(url)) {
                //   await launch(url);
                // } else {
                //   Fluttertoast.showToast(msg: "Could not launch phone dialer");
                // }
                Get.to(PaymentMethodsScreen());
              },

              // label: const Text('To the lake!'),
              child: Text(
                "SOS",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   Print.p("into the _goTotheLake()");
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
// this is fo the top part of the google map
//
