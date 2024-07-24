import 'package:ambulance_test/utility/constants.dart';
import 'package:get/get.dart';

class ListTileController extends GetxController
{
  Rx<String> feedBackValue="No Longer Needed".obs;
  Rx<String> otherReason="".obs;
  void changeFeedBackValue(String value){
    feedBackValue.value=value;
    toast(msg: feedBackValue.value.toString());
  }
  void setOtherReason(String value){
    otherReason.value=value;
  }
}