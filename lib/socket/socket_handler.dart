import 'package:ambulance_test/main.dart';
import 'package:ambulance_test/screens/CancelScreen/cancellation_reason_screen.dart';
import 'package:ambulance_test/screens/Payment/payment_methods_screen.dart';
import 'package:ambulance_test/screens/startRide/controller/tracking_contrroller.dart';
import 'package:ambulance_test/screens/startRide/drive_live_location_screen.dart';
import 'package:ambulance_test/screens/feeedback/feedback_screen.dart';
import 'package:ambulance_test/screens/ride_confirmation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../screens/searchDriver/controller/ride_controller.dart';
import '../utility/constants.dart';

class SocketHandler {
  late Socket socket;

  bool listenEvent() {
    Print.p("in listen Events()");
    if (socket.connected) {
      socket.on('driverLocation', (data) {
        Print.p("In driverLocation");

        Get.find<TrackingController>().setDriverPosition(LatLng(
            double.parse(data["latitude"].toString()),
            double.parse(data["longitude"].toString())));
        Print.p(data.toString());
      });

      socket.on('otpVerifyNotified', (data) async{
        Print.p("In otpVerifyNotified");
        var trackCon = Get.find<TrackingController>();
        var reqData = Get.find<RideController>().requestData.value;
        await trackCon.setDrirection(
            origin: trackCon.driverPosition.value,
            dest: LatLng(reqData["dropLocation"]["latitude"],
                reqData["dropLocation"]["longitude"]),isgoignToDropLocation: true);

        trackCon.isOtpVerified.value = true;
        // Print.p("going to call  setDirection");

        Print.p(data.toString());
      });

      socket.onDisconnect((_) {
        Print.p('disconnect');
      });

      socket.on("requestAccepted", (data) {
        Print.p("requestAccepted By driver");
        Print.p(data.toString());
        var rideCon = Get.find<RideController>();
        rideCon.setRequestData(newData: data, isAddConnectListenfun: false);
        emitDriverNumber(rideCon.requestData.value["driverPhoneNumber"]);
        Get.to(DriveLiveLocationScreen());
      });

      socket.on("rideCompleted", (data) {
        Print.p("rideCompleted By driver");
        Print.p(data.toString());
        var rideCon = Get.find<RideController>();
        Get.off(RideConfirmation(
          pickupAdd: rideCon.requestData.value["pickupAddress"].toString(),
          dropAdd: rideCon.requestData.value["dropAddress"].toString(),
          price: rideCon.requestData.value["fare"].toString(),
        ));
      });

      socket.on("dropOffNotified", (data) {
        Print.p("dropOffNotified ");
        Get.to(PaymentMethodsScreen());

      });
      return true;
    } else {
      return false;
    }
  }

  bool registerClient() {
    if (socket.connected) {
      var userNumber = sharedInstance.getString("number");
      socket.emit("registerClient", int.parse(userNumber));
      Print.p(" in registerClient()");
      return true;
    } else {
      return false;
    }
  }

  bool emitDriverNumber(String driverNumber) {
    if (socket.connected) {
      socket.emit("phoneNumber", driverNumber);
      return true;
    } else {
      return false;
    }
  }

  bool cancelRideAfterDriverAcceptance(Map<String, dynamic> data) {
    if (socket.connected) {
      socket.emit("cancelRide", data);

      return true;
    } else {
      return false;
    }
  }

  void connectAndListen() {
    Print.p("In connectAndListen ()");
    socket = io("https://livetracking-backend.onrender.com", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": true
    });
    socket.connect();
    socket.onConnect((_) {
      Print.p("Connected to the sever");
      listenEvent();
      registerClient();
    });
  }

  void socketDisconnect() {
    socket.disconnect();
  }
}
