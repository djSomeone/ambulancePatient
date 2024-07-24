import 'dart:async';

import 'package:ambulance_test/api/response_structure.dart';
import 'package:ambulance_test/main.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' ;

import '../utility/directionPoint/directions_model.dart';

class Api {
  static final dio = Dio();
  static var endPoint = "https://ambulance-booking-backend.vercel.app/";
  // static var socket = io("https://livetracking-backend.onrender.com", <String, dynamic>{
  // "transports": ["websocket"],
  // "autoConnect": true
  // });

//   socketIo conection endPoint

// searching  for the nearby
  static var nearByRoute = "user/nearbysearch";
  static var sendOTP = "user/patient-send-otp";
  static var verifyOTP = "user/patient-verify-otp";
  static var createProfil = "user/patient-profile";

  // this is for the searching for the pickup location
  static var searchLocation = "user/search-locations";

  // this is for the getting current location address
  static var humanReadableAdd = "user/get-address";

//   this is for  the search hospital in  hydrabad
  static var searchHospital = "user/hydrebad-hospital";

  // requesting for the driver
  static var requestAmbulance = "user/patient-request";
  static var cancelRideReason = "user/add-cancel-reason";
  static var cancelRequestRide = "user/cancel-request";
  static var rideHistory = "user/patient-booking-history";
  static var feedBack = "user/create-feedback";




// this is for getting the NearBy hospitals
  static Future<Map<String, dynamic>> getNearBy({required LatLng location,
    String radius = "1000",
    String type = "hospital"}) async {
    String finalLocation = "${location.latitude},${location.longitude}";
    String finalPath =
        "$endPoint$nearByRoute?location=$finalLocation&type=$type&radius=$radius";
    Print.p(finalPath);
    Response response = await dio.get(finalPath);
    var finalResponse = ResponseStructure.toResponseStructure(response);
    // Print.p(finalPath);
    // Print.p(finalResponse.toString());

    return finalResponse;
  }
  // static void checkSocket({required String driverPhoneNumber}) {
  //   Print.p("in getRealtimeDriverLcation()");
  //
  //   socket.connect();
  //
  //   socket.onConnect((_) {
  //     Print.p('connect');
  //     socket.emit('phoneNumber', driverPhoneNumber);
  //   });
  //   socket.on('driverLocation', (_) => Print.p(_.toString()));
  //   socket.onDisconnect((_) => Print.p('disconnect'));
  //
  //   Print.p("end of getRealtimeDriverLcation()");
  // }

  // static void socketDisconnect() {
  //   socket.disconnect();
  // }

//   this is implementation of the sendOTP Api
  static Future<void> sendOtp(Map data) async {
    // String finalLocation = "${location.latitude},${location.longitude}";
    String finalPath = "$endPoint$sendOTP";
    Print.p(finalPath);
    Print.p(data.toString());
    Response response = await dio.post(finalPath, data: data);
    var finalResponse = response.data;

    Print.p(finalResponse.toString());

    // return finalResponse;
  }

  static Future<Map<String, dynamic>> verifyOtp(Map data) async {
    String finalPath = "$endPoint$verifyOTP";
    Print.p(finalPath);
    Print.p(data.toString());
    Print.p("before api call");
    Response response = await dio.post(finalPath, data: data);
    Print.p("after api call");
    var finalResponse = response.data;

    Print.p(finalResponse.toString());
    return ResponseStructure.toResponseStructure(response);

    // return finalResponse;
  }

  static Future<Map<String, dynamic>> createProfile(Map data) async {
    String finalPath = "$endPoint$createProfil";
    Response response = await dio.post(finalPath, data: data);
    return ResponseStructure.toResponseStructure(response);

    // return finalResponse;
  }

  static Future<Map<String, dynamic>> getLocationSearched(
      String address) async {
    String finalPath = "$endPoint$searchLocation?address=$address";
    Print.p(finalPath.toString());
    Response response = await dio.get(finalPath);
    Print.p(response.toString());
    return ResponseStructure.toResponseStructure(response);

    // return finalResponse;
  }

  static Future<Map<String, dynamic>> getHumanReadableAdd(
      LatLng position) async {
    String finalPath =
        "$endPoint$humanReadableAdd?lat=${position.latitude}&lng=${position
        .longitude}";
    Print.p(finalPath.toString());
    Response response = await dio.get(finalPath);
    Print.p(response.toString());
    return ResponseStructure.toResponseStructure(response);

    // return finalResponse;
  }

  // panding ui integration
  static Future<Map<String, dynamic>> sendRequestForAmbulance(LatLng pickUp,
      LatLng dropLoc) async {
    String finalPath = "$endPoint$requestAmbulance";
    Print.p(finalPath.toString());
    var data = {
      "patientPhoneNumber": sharedInstance.getString("number"),
      "patientName": sharedInstance.getString("userName"),
      "pickupLocation": {
        "latitude": pickUp.latitude,
        "longitude": pickUp.longitude
      },
      "dropLocation": {
        "latitude": dropLoc.latitude,
        "longitude": dropLoc.longitude
      },

    };
    Response response = await dio.post(finalPath, data: data);
    Print.p(response.toString());
    return ResponseStructure.toResponseStructure(response);
  }

  // panding ui integration
  static Future<Map<String, dynamic>> getSearchedHospitalData(
      String keyword) async {
    String finalPath = "$endPoint$searchHospital?keyword=$keyword";
    Print.p(finalPath.toString());
    Response response = await dio.get(finalPath);
    Print.p(response.toString());
    return ResponseStructure.toResponseStructure(response);

    // return finalResponse;
  }






  static Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await dio.get(
      'https://maps.googleapis.com/maps/api/directions/json?',
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': "AIzaSyBpX6Opy9xgc98uyaMioJ8VbzJYHXnqE4Q",
      },
    );
    Print.p("response");
    Print.p(response.data["status"].toString() );
    if (response.statusCode == 200 && response.data["status"].toString()!="ZERO_RESULTS" ) {
      return Directions.fromMap(response.data);
    }
    return null;
  }

  static Future<Map<String,dynamic>> getRideHistory()
  async {
    var number=sharedInstance.getString("number");
    Print.p(number.toString());
    var finalPath="$endPoint$rideHistory?patientPhoneNumber=$number";
    Print.p(finalPath);
    final response = await dio.get(finalPath);
    return ResponseStructure.toResponseStructure(response);

  }

  static Future<Map<String, dynamic>> sendCancelReason(String reqId,String reason) async {
    String finalPath = "$endPoint$cancelRideReason";
    Print.p(finalPath.toString());
    var data = {
      "requestId":reqId,
      "reason": reason

    };
    Response response = await dio.post(finalPath, data: data);
    Print.p(response.toString());
    return ResponseStructure.toResponseStructure(response);
  }

  static Future<Map<String, dynamic>> sendfeedBack(String reqId,String driverNumber,String rating,String feedback) async {
    String finalPath = "$endPoint$feedBack";
    Print.p(finalPath.toString());
    var data = {
      "requestId": reqId,
      "driverPhoneNumber": driverNumber,
      "patientName": sharedInstance.getString("userName"),
      "rating": int.parse(rating),
      "feedback": feedback
    };
    Response response = await dio.post(finalPath, data: data);
    Print.p(response.toString());
    return ResponseStructure.toResponseStructure(response);
  }

  // // panding to integrate with ui
  // static Future<Map<String, dynamic>> setCancelRequestedRide(String reqId) async {
  //   String finalPath = "$endPoint$cancelRequestRide";
  //   Print.p(finalPath.toString());
  //   var data = {
  //     "requestId":reqId,
  //
  //   };
  //   Response response = await dio.post(finalPath, data: data);
  //   Print.p(response.toString());
  //   return ResponseStructure.toResponseStructure(response);
  // }
}


