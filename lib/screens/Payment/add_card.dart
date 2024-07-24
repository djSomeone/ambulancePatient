import 'dart:convert';

import 'package:ambulance_test/main.dart';
import 'package:ambulance_test/screens/Payment/module/add_card_text_feild.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../module/drop_down/controller/drop_down_controller.dart';

class AddCard extends StatelessWidget {
 AddCard({super.key});
  var cardNumberCon=TextEditingController();
  var holderNameCon=TextEditingController();
  var expDateCon=TextEditingController();
  var cvvCon=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: ConstColor.primery,
            ),
          ),
          title: Text(
            "Add new card",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: ConstColor.grey,
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 180,child: Image(image: AssetImage("asset/card.png"),),),
                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: ListView(

                    children: [
                      AddCardTextFeild(title: "Cardholder name",controller: holderNameCon,maxLength: 20,),

                      AddCardTextFeild(title: "Card number",keyBoradType: TextInputType.number,controller: cardNumberCon,),
                      Row(
                        children: [
                          Expanded(child: AddCardTextFeild(title: "Exp date",keyBoradType: TextInputType.datetime,controller: expDateCon,)),
                          SizedBox(width: 20,),
                          Expanded(child: AddCardTextFeild(title: "CVV",maxLength: 3,keyBoradType: TextInputType.number,controller: cvvCon,)),
                        ],
                      )
                      // AddCardTextFeild(title: "",),

                    ],
                  ),
                )),
                standardButton(title: "Save",
                    onPressed: (){
                  if(cardNumberCon.text.length==16 && holderNameCon.text!="" && expDateCon.text.length>=5 && cvvCon.text.length==3)
                    {
                      localizeCardDetails();
                    }
                  else{
                    toast(msg: "Invailid Card Deetails");
                  }
                    })

              ],
            )),
      ),
    );
  }

  Future<void> localizeCardDetails()
 async {
    var cardHolderName=holderNameCon.text;
    var cvv=cvvCon.text;
    var expDate=expDateCon.text;
    var cardNumber=cardNumberCon.text;
    final data={"cardHolderName": cardHolderName,"cvv":cvv,"expDate":expDate,"cardNumber":cardNumber};
    var cardDetailsString=sharedInstance.getString("cardDetails");
    if(cardDetailsString==null){
      // Print.p("there is no card added befor");
      await sharedInstance.setString("cardDetails",jsonEncode([data]));
      Get.find<DropDownController>().updateCardDetails();
      // Print.p(sharedInstance.getString("cardDetails").toString());
    }
    else{
      // Print.p("befor adding new card");
      // Print.p(sharedInstance.getString("cardDetails").toString());
      var x=jsonDecode(cardDetailsString);
      x.add(data);
      cardDetailsString=jsonEncode(x);
      await sharedInstance.setString("cardDetails",cardDetailsString);
      toast(msg: "Card added successfully.");
       Get.find<DropDownController>().updateCardDetails();
      // Print.p("After adding new card");
      // Print.p(sharedInstance.getString("cardDetails").toString());

    }
    Get.back();
  }

}
