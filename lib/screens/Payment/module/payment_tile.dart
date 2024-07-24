import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/constants.dart';
import '../controller/payment_screen_controller.dart';

class PaymentTile extends StatelessWidget {
  PaymentMethod method;
  String text;
  var paymentMethodController=Get.find<PaymentScreenController>();
   PaymentTile({required this.method,required this.text});


  @override
  Widget build(BuildContext context) {
    return  Obx(
      ()=> Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          height: 56,
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: ElevatedButton(

                style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFEFDFDFD),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), // Set your desired radius
                  ), ),


                onPressed: (){
                  Print.p("on tap");
                  paymentMethodController.changePaymentMethod(method);
                }, child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text,style: TextStyle(color: Colors.black,fontSize: 14),),
                Radio<PaymentMethod>(value: method,

                    activeColor: Colors.black,
                    groupValue: paymentMethodController.choosedMethod.value,
                    onChanged: (x){
                      // Print.p(x.runtimeType.toString());
                      paymentMethodController.changePaymentMethod(x!);
                    })
              ],
            )),
          ),
        ),
      ),
    );
  }
}
