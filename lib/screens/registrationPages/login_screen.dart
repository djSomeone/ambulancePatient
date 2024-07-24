// import 'package:flutter/cupertino.dart';

import 'package:ambulance_test/api/api.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/utility/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'otp_verification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final borderDeco =
      BoxDecoration(border: Border.all(color: Colors.black, width: 1));
  // final _formKey = GlobalKey<FormState>();
  var numController = TextEditingController();
  var textColorPrime = TextStyle(color: ConstColor.primery);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  // bool isDriver=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: ScreenSize.h,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 50, right: 10, left: 10),
            child: Column(
              children: [
                // top part include img and heading
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        // decoration: borderDeco,
                        height: 250,
                        width: 250,
                        child: SvgPicture.asset(
                            'asset/homePageImg/ambulanceImage.svg')
                        // Text('Empty')
                        ,
                      ),
                      // heading
                      Container(
                          // decoration: borderDeco,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                                child: Text(
                                                    'Welcome to Synco Ambulances',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                              color: Colors.grey[600],
                              fontSize: TextSize.headingFontSize,),
                                                  )),
                          )),
                    ],
                  ),
                ),

                // form
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // title to the textFeild
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Login/SignUp",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                              controller: numController,
                              keyboardType: TextInputType.number,
                              cursorColor: ConstColor.primery,
                              maxLength: 10,
                              decoration: InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: "Mobile number",
                                prefixIcon: Icon(
                                  Icons.call,
                                  color: Colors.black45,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ConstColor.primery, width: 2),
                                  borderRadius: BorderRadius.circular(20.0),

                                  // Set your desired corner radius
                                ),
                              )),
                        ),
                        Expanded(
                          child: Center(),
                        ),

                        standardButton(title: "Submit", onPressed: onSubmit),
                        Container(
                          // decoration: borderDeco,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 14),
                          child: RichText(
                            text: TextSpan(
                              text: 'By continuing, you agree to our ',
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Terms of Use ',
                                  style: textColorPrime,
                                ),
                                TextSpan(
                                  text: 'and ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: textColorPrime,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit() async {

    Print.p(numController.text.length.toString());
    try {
      if (numController.text.length == 10) {
        Print.p("in if block");
        FocusScope.of(context).unfocus();
        var data = {"phoneNumber": numController.text};

        await Api.sendOtp(data);
        await toast(msg: "OTP send successfully");
        Get.to(OtpVerification(
          number: numController.text.toString(),
        ));
      } else {

        await toast(msg: "Failed to send OTP");
      }
    } catch (x) {

      toast(msg: "there is some issue");
    }
  }
}
