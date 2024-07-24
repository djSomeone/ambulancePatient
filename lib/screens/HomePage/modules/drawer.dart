import 'package:ambulance_test/main.dart';
import 'package:ambulance_test/screens/registrationPages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../utility/constants.dart';
import '../../MyBookingsPage/my_bookings_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var elevation=3.0;
    return Drawer(
        backgroundColor: ConstColor.grey,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), // Set corner radius
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Center(child: Icon(Icons.person,color: Colors.white,size: 80,),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(sharedInstance.getString("userName"),style: TextStyle(fontSize: 22),),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Material(
                  elevation: elevation,
                  borderRadius: BorderRadius.circular(10),
                  color: ConstColor.grey,
                  child: ListTile(

                    leading: Icon(Icons.home,color: ConstColor.primery,),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey)),
                    title: Text('Home'),
                    onTap: () {
                      // Navigate to the home screen
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Material(
                  elevation: elevation,
                  color: ConstColor.grey,
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    leading: Icon(Icons.car_crash,color: ConstColor.primery,),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey)),
                    title: Text('My Bookings'),
                    onTap: () {
                      // Navigate to the home screen
                      Navigator.pop(context);// Close the drawer
                      Get.to(MyBookingsScreen());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Material(
                  elevation: elevation,
                  color: ConstColor.grey,
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    leading: Icon(Icons.question_mark_sharp,color: ConstColor.primery,),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey)),
                    title: Text('Help & Support'),
                    onTap: () {
                      // Navigate to the home screen
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Material(
                  elevation: elevation,
                  color: ConstColor.grey,
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    leading: Icon(Icons.security,color: ConstColor.primery,),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey)),
                    title: Text('Privacy Policy'),
                    onTap: () {
                      // Navigate to the home screen
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Material(
                  elevation: elevation,
                  color: ConstColor.grey,
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app,color: ConstColor.primery,),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.grey)),
                    title: Text('Log Out'),
                    onTap: (){
                      showDialog(context: context,
                          builder: (context)=>
                             standaredAlertBox(title: "LogOut?", subTitle: "Are you sure want to logOut?",
                                 firstButtonColor: ConstColor.DarkGrey, secoundButtonColor: ConstColor.primery,
                                 onTapFirstButton: (){
                               Get.back();
                                 },
                                 onTapSecoundButton: ()async{
                               removeUserData();
                               Get.offAll(LoginPage());
                                 }, textFirstButton: "Cancel", textSecoundButton: "LogOut")); },
                  ),
                ),
              ),


            ],
          ),
        )
    );
  }
  void logOut()
  {}
}
