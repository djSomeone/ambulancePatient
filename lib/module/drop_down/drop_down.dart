import 'dart:convert';

import 'package:ambulance_test/main.dart';
import 'package:ambulance_test/module/drop_down/controller/drop_down_controller.dart';
import 'package:ambulance_test/module/drop_down/module/tile.dart';
import 'package:ambulance_test/screens/Payment/controller/payment_screen_controller.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDown extends StatefulWidget {





  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  var controller=Get.put(DropDownController());


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          controller.toggel();
          // Get.find<PaymentScreenController>().changePaymentMethod(PaymentMethod.debitCard);
        },
        child: Obx(
          ()=> AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: controller.isTap.value?controller.cardsDetails.value!=[]?270:150:58,
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(10),
              child: Container(

                clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xFFFDFDFD),),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Text("Debit Card",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                              Padding(
                                padding: const EdgeInsets.only(right:14 ),
                                child: controller.isTap.value?Icon(Icons.keyboard_arrow_up_rounded,size: 28,):Icon(Icons.keyboard_arrow_down_outlined,size: 28,),
                              )
                          ],),
                        ),
                        // controller.isTap.value?SizedBox(height: 10,):SizedBox(),
                        controller.isTap.value?Expanded(flex:3,child: ListView.builder(itemBuilder: (context,index){
                          return
                          DropDownTile(cardNumber: controller.cardsDetails[index]["cardNumber"],);
                          // controller.isTap.value?Expanded(child: Divider(color: Color(0xFFD2D2D2),)):SizedBox(),


                        },itemCount: controller.cardsDetails.length,)):SizedBox(),
                        // controller.isTap.value?Expanded(child: DropDownTile()):SizedBox(),
                        // controller.isTap.value?Expanded(child: Divider(color: Color(0xFFD2D2D2),)):SizedBox(),
                        // controller.isTap.value?Expanded(child: DropDownTile()):SizedBox(),
                        controller.isTap.value?Divider(color: Color(0xFFD2D2D2),):SizedBox(),
                        controller.isTap.value?Expanded(flex:1,child: DropDownTile(isAddNewCard: true,)):SizedBox(),



                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}