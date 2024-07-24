import 'package:ambulance_test/screens/CancelScreen/controller/list_tile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/constants.dart';

class CancelListTile extends StatelessWidget {
  late var value;
  late var title;


   CancelListTile({required this.value,required this.title,});
   var controller=Get.find<ListTileController>();

  @override
  Widget build(BuildContext context) {
    var borderColor=Color(0xFFD5DDE0);
    return GestureDetector(
      onTap: (){
        controller.changeFeedBackValue(value);
      },
      child: SizedBox(height: 56,child: Row(children: [
        Expanded(flex:1,child: Obx(()=>Radio<String>(value: value,groupValue:controller.feedBackValue.value ,
          onChanged: (x){controller.changeFeedBackValue(x!);},
          fillColor:WidgetStateProperty.all(ConstColor.primery),
        ))),
        Expanded(flex:8,child: Container(
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(title),
              )
            ],
          ),
        )),
      ],),),
    );
  }
}
