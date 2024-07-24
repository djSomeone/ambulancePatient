import 'dart:ui';

import 'package:ambulance_test/screens/feeedback/controller/feedback_controller.dart';
import 'package:ambulance_test/screens/feeedback/feedback_screen.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StarDisplay extends StatelessWidget {
  final int value;
   double size;
   Color color;
  bool isClickable;
   StarDisplay({this.value = 0,this.size=18,this.color=Colors.yellow,this.isClickable=false});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: isClickable?(){
            var con =Get.find<FeedbackController>();
            con.setRating(index);
          }:(){},
          child: Icon(
             Icons.star,
          color: index < value?color:Colors.blueGrey,size: size,),
        );
      }),
    );
  }
}