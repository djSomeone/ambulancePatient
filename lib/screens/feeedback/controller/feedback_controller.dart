import 'package:ambulance_test/utility/constants.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController
{
  RxInt rating=0.obs;
  RxString feedBackValue="Punctual".obs;
  RxString otherFeedBack="Punctual".obs;

  void setRating(int newValue)
  {
    if(newValue!=rating.value){
      rating.value=(newValue+1);
      toast(msg: rating.value.toString());
    }
  }
  void setFeedBackValue(String newFeedBack)
  {
    if(newFeedBack!=feedBackValue.value){
      feedBackValue.value=newFeedBack;
    }
  }
  void setOthereFeedBack(String newFeedBack)
  {
    if(newFeedBack!=otherFeedBack.value){
      otherFeedBack.value=newFeedBack;
    }
  }
}