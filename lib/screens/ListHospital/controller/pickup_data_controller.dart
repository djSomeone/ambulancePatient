import 'package:get/get.dart';

import '../../../api/api.dart';
import '../../../utility/constants.dart';

class PickupDataController extends GetxController
{
  RxList data =[].obs;
  RxBool isLoading=false.obs;


  void setData(String add)
  async{
    try{
      isLoading.value=true;
      var res=await Api.getLocationSearched(add);
      data.value=res["body"];
      isLoading.value=false;

    }
    catch(x){
      isLoading.value=false;
      data.value=[];
      Print.p("thereis error");
      // data.value=[];
    }
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    data.value=[];
  }

}