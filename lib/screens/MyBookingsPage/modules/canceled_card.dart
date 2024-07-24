import 'package:ambulance_test/screens/MyBookingsPage/modules/complete_card.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';

class CanceledCard extends StatelessWidget {
   CanceledCard({required this.driverName,
     required this.reqId,
     required this.pickLocation,
     required this.dropLocation,
     required this.amount,
     required this.distance,
     required this.date,
     required this.time,});

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
    return SizedBox(
      height: 280,
      child: Column(
        children: [
          CompleteCard(
              reqId: reqId,
              driverName: driverName,
              amount: amount,
              distance: distance,
              pickLocation: pickLocation,
              dropLocation: dropLocation,
              date: date,
              time: time,
              borderRadius:BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Color(0xFFE8E8E8)),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ride Canceled",style: TextStyle(color: Colors.redAccent),)
                  ],),
              ),
            ),
          ))
        ],
      ),
    );
  }
}