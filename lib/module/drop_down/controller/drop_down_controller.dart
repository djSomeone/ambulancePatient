import 'dart:convert';

import 'package:ambulance_test/main.dart';
import 'package:get/get.dart';

class DropDownController extends  GetxController
{
RxBool isTap=false.obs;
RxList cardsDetails=[].obs;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cardsDetails.value=jsonDecode(sharedInstance.getString("cardDetails")??"[]");
  }

void toggel(){
  bool currentVal=isTap.value;
  isTap.value=!currentVal;
}

void updateCardDetails()
{
  cardsDetails.value=[];
  cardsDetails.value=jsonDecode(sharedInstance.getString("cardDetails")??"[]");
}

}