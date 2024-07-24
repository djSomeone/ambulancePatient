import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../HomePage/modules/location_selector_card.dart';

class CompleteCard extends StatelessWidget {
  CompleteCard({required this.borderRadius,
    required this.driverName,
    required this.reqId,
    required this.pickLocation,
    required this.dropLocation,
    required this.amount,
    required this.distance,
    required this.date,
    required this.time,
    this.isBoxShadow = false});
  BorderRadius borderRadius;
  bool isBoxShadow;

  //  data
  String driverName;
  String amount;
  String distance;
  String pickLocation;
  String dropLocation;
  String date;
  String time;
  String reqId;

  @override
  Widget build(BuildContext context) {
    var txtgrey = TextStyle(color: Colors.blueGrey,fontSize: 14);
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE8E8E8)),
            borderRadius: borderRadius),
        height: 230,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              // top
              Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black38,
                        child: Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                           driverName,
                            style: TextStyle(fontSize: 14,fontWeight:FontWeight.w600,overflow: TextOverflow.ellipsis),
                          )),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: Column(

                              children: [
                                Text(
                                  "Fare",
                                  style: txtgrey,
                                ),
                                Text(
                                  "\u{20B9}${(double.parse(amount)).toInt().toString()}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: ConstColor.secoundary),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Distance",
                                  style: txtgrey,
                                ),
                                Text(
                                  "${distance}km",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                          )
                        ],
                      ))
                      // Divider()
                    ],
                  )),
              Divider(),
              // pick drop
              Expanded(
                flex: 5,
                child: standaredpickupDropCard(isOneLine:true,pickupLocation:pickLocation,dropLocation:dropLocation,withoutBox: true),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          time,
                          style: txtgrey,
                        ),
                        Text(
                          date,
                          style: txtgrey,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
