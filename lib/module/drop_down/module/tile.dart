import 'package:ambulance_test/screens/Payment/add_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/constants.dart';

class DropDownTile extends StatelessWidget {
   DropDownTile({this.isAddNewCard=false, this.cardNumber=""});
  var bankName = "Axis Bank";
  var cardNumber;
  var isAddNewCard = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: isAddNewCard
          ? GestureDetector(
        onTap: (){
          Print.p("Add card screen");
          Get.to(AddCard());
        },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                    children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.add_circle_outline_outlined,size: 35,color: Color(0xFFD96D1F),),
            ),
            Text("Add New Card",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
            Expanded(child: SizedBox())
                    ],
              ),
          )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Image(
                    image: AssetImage("asset/cardicon.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                    child:  Text(
                      cardNumber,
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    )
                ),
                Radio(value: "value", groupValue: "value", onChanged: (x) {}),

              ],
            ),

    );
  }
}
