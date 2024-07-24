import 'package:get/get.dart';


import '../../../utility/constants.dart';
class PaymentScreenController extends GetxController
{
  Rx<PaymentMethod> choosedMethod=PaymentMethod.payByCash.obs;
  void changePaymentMethod(PaymentMethod newMethod)
  {
    choosedMethod.value=newMethod;
    toast(msg: choosedMethod.toString());
  }
}