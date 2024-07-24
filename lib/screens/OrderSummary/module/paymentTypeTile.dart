import 'package:ambulance_test/screens/Payment/controller/payment_screen_controller.dart';
import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentTypeTile extends StatelessWidget {
  String title;
  PaymentMethod value;
   PaymentTypeTile(

  {required this.title,required this.value
});
   var controller=Get.put(PaymentScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title)),
          Radio<PaymentMethod>(
            activeColor: Colors.black,
            value: value,
            groupValue: controller.choosedMethod.value,
            onChanged: (value) {
              controller.changePaymentMethod(value as  PaymentMethod);
            },
          ),
        ],
      ),
    );
  }
}
