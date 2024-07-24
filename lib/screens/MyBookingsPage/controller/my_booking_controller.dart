import 'package:get/get.dart';

import '../../../api/api.dart';
import '../../../utility/constants.dart';

class MyBookingController extends GetxController
{
  Rx<int> pageIndex=0.obs;
  RxList ongingData=[].obs;
  RxList completedData=[].obs;
  RxList cancelledData=[].obs;
  void changePageIndex(int newIndex)
  {
    pageIndex.value=newIndex;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
  void getData()
  async
  {
    Print.p("in myBookingController getData()");
     var r=await Api.getRideHistory();
    ongingData.value=[];
    completedData.value=[];
    cancelledData.value=[];
     ongingData.value=r["body"]["accepted"];
     completedData.value=r["body"]["completed"];
     cancelledData.value=r["body"]["cancelled"];

     Print.p(ongingData.value.toString());
     Print.p(completedData.value.toString());
     Print.p(cancelledData.value.toString());

  }
}