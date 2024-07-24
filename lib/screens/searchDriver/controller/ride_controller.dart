import 'package:ambulance_test/socket/socket_handler.dart';
import 'package:get/get.dart';

import '../../../utility/constants.dart';

class RideController extends GetxController
{
  RxMap<String,dynamic> requestData=Map<String,dynamic>().obs;
  var socket=SocketHandler();
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    socket.socketDisconnect();

  }
  void setRequestData({required Map<String, dynamic> newData,bool isAddConnectListenfun=true})
  {
    requestData.value={};
    requestData.value=newData;
    Print.p("setting request data successfully");
    Print.p(requestData.value.toString());

    if(isAddConnectListenfun)
      {
        socket.connectAndListen();
      }




  }
void reinitializeController(){
   Print.p("Reinitialize rideControlleer");
  requestData.value=Map<String,dynamic>();
  socket.socketDisconnect();
}
}