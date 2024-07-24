import 'package:ambulance_test/screens/HomePage/google_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import '../../main.dart';
import '../../utility/constants.dart';

class NameGetScreen extends StatelessWidget {
  String number="";
   NameGetScreen({required this.number});

  var nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,leading: Text(""),),
      extendBodyBehindAppBar: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex:3,child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("What's your name?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Text(textAlign: TextAlign.center,"Please enter your name to help us provide the best possible care",
                    style: TextStyle(fontSize: 12),),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: TextFormField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                      controller: nameController,
                      keyboardType:TextInputType.text,
                      cursorColor: ConstColor.primery,
                      decoration: InputDecoration(
                        fillColor: Colors.white70,

                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: ConstColor.grey,width: 3)),
                        // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.transparent,width: 3)),
                        hintText: "Enter Full Name",
                        hintStyle: TextStyle(fontSize: 14),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,width: 2),
                          borderRadius: BorderRadius.circular(10.0),


                          // Set your desired corner radius
                        ),
                      )
                  ),
                ),

              ],
            )),

            Expanded(flex:1,
                child:Padding(

                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.end,
                    children: [

                      standardButton(title: "Continue", onPressed: onSubmit)
                      // SizedBox(
                      //   height: 50,
                      //   child: ElevatedButton(
                      //
                      //
                      //       style:ElevatedButton.styleFrom(backgroundColor:ConstColor.secoundary,
                      //         shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), // Set your desired radius
                      //         ), ),
                      //
                      //       onPressed: onSubmit, child: Center(child: Text("Continue",style: TextStyle(color: Colors.white),),)),
                      // )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
  void onSubmit()async{
    try{
      if (!(nameController.text.toString() == "")) {
        var data = {"phoneNumber": this.number, "name": nameController.text};
        var res = await Api.createProfile(data);
        await Fluttertoast.showToast(
            msg: nameController.text.toString(),
            backgroundColor: Colors.white,
            textColor: Colors.grey);
        // Get.offAll(MapScreen());
        FocusManager.instance.primaryFocus?.unfocus();
       if(res["body"]["message"]=="Profile created successfully") {
         var number=this.number;
         var name=res["body"]["patientProfile"]["name"];
          localizeUserData(number, name);
          Get.offAll(MapScreen());
        }
       else{
         toast(msg: "failed to create profile");
       }
      }
      else {
       toast(msg: "Please enter name");}
    }
    catch(x)
    {
      Print.p(x.toString());
    }
  }
}
