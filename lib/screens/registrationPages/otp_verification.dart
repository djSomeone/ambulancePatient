import 'package:ambulance_test/main.dart';
import 'package:ambulance_test/screens/registrationPages/login_screen.dart';
import 'package:ambulance_test/screens/registrationPages/name_get_screen.dart';
import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import '../../api/api.dart';
import 'controller/otp_verification_controller.dart';
import '/utility/constants.dart';
import '../HomePage/google_map_screen.dart';

class OtpVerification extends StatefulWidget {
  var number;
   OtpVerification({required this.number });

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  var controller=Get.put(optVerificationController());
  // var con=Get.find<UserDataController>();


  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // this clearing the otp entered into the screen
    controller.reConstruct("");
    // we have to make the clickable for the login screen
    // con.setClick(true);
  }
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: ScreenSize.h,
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            // decoration: ConstBorder.bDeco,
            height: ScreenSize.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Empty')
                // ,
                SvgPicture.asset('asset/verificationScreenImg/verifyImg.svg',height: 150,width: 150,),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "We need to register your phone number to get started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 30,
                ),
                ///  Otp pin Controller

                OtpPinField(
                  key: _otpPinFieldController,
                  ///in case you want to enable autoFill
                  autoFillEnable: false,

                  ///for Ios it is not needed as the SMS autofill is provided by default, but not for Android, that's where this key is useful.
                  textInputAction: TextInputAction.done,

                  ///in case you want to change the action of keyboard
                  /// to clear the Otp pin Controller
                  onSubmit: (text) {
                    print('Entered pin is $text');

                    // controller.reConstruct(text);

                    /// return the entered pin
                  },
                  onChange: (text) {
                    print('Enter on change pin is $text');
                    controller.reConstruct(text);

                    /// return the entered pin
                  },


                  /// to decorate your Otp_Pin_Field
                  otpPinFieldStyle: OtpPinFieldStyle(
                    /// border color for inactive/unfocused Otp_Pin_Field
                    defaultFieldBorderColor: Colors.transparent,

                    /// border color for active/focused Otp_Pin_Field
                    activeFieldBorderColor: Colors.black,

                    /// Background Color for inactive/unfocused Otp_Pin_Field
                    defaultFieldBackgroundColor: Colors.grey.withOpacity(0.7),

                    /// Background Color for active/focused Otp_Pin_Field
                    activeFieldBackgroundColor: Colors.grey.withOpacity(0.7),

                    /// Background Color for filled field pin box
                    filledFieldBackgroundColor: Colors.grey.withOpacity(0.7),

                    /// border Color for filled field pin box
                    filledFieldBorderColor: Colors.black,
                    //
                    /// gradient border Color for field pin box
                    // fieldBorderGradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
                  ),
                  maxLength: 4,

                  /// no of pin field
                  showCursor: true,

                  /// bool to show cursor in pin field or not
                  cursorColor: Colors.black,

                  /// to choose cursor color


                  ///bool which manage to show custom keyboard
                  // showCustomKeyboard: true,
                  /// Widget which help you to show your own custom keyboard in place if default custom keyboard
                  // customKeyboard: Container(),
                  ///bool which manage to show default OS keyboard
                  // showDefaultKeyboard: true,

                  /// to select cursor width
                  cursorWidth: 1,

                  /// place otp pin field according to yourself
                  mainAxisAlignment: MainAxisAlignment.center,


                  autoFocus: false,
                  /// predefine decorate of pinField use  OtpPinFieldDecoration.defaultPinBoxDecoration||OtpPinFieldDecoration.underlinedPinBoxDecoration||OtpPinFieldDecoration.roundedPinBoxDecoration
                  ///use OtpPinFieldDecoration.custom  (by using this you can make Otp_Pin_Field according to yourself like you can give fieldBorderRadius,fieldBorderWidth and etc things)
                  otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
                ),

                const SizedBox(
                  height: 50,
                ),
                standardButton(title: "Verify", onPressed: verifyOtp),


                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigator.pushNamedAndRemoveUntil(
                          //   context,
                          //   'phone',
                          //       (route) => false,
                          // );
                        },
                        child: Text(
                          "Edit Phone Number ?",
                          style: TextStyle(color: Colors.black,fontSize: 14),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void verifyOtp()async{
    if(controller.otp.value.length==4){
      try {
        var data = {
          "phoneNumber": widget.number,
          "OTP": controller.otp.value.toString()
        };
        Print.p("after data");
        var res = await Api.verifyOtp(data);

        Print.p("before redirect..");
        if (res["body"]["isVerified"] == true &&
            res["body"]["isRegistered"] == true) {
          //setting into the disk for persistency
          var number = widget.number;
          var name = res["body"]["patientProfile"]["name"];
          localizeUserData(number, name);
          //
          Get.offAll(MapScreen());
        } else {
          if (res["body"]["isVerified"] == true) {
            Get.to(NameGetScreen(
              number: widget.number,
            ));
          } else {
            toast(msg: "Invailied OTP");
          }
        }
      } catch (x) {
        toast(msg: "there is some issue /${x.toString()}");
        Print.p(x.toString());
      }
    }else{
      toast(msg: "Invailid");
    }
  }
}


