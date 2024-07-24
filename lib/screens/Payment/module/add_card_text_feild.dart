import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCardTextFeild extends StatelessWidget {
  var title="";
  int maxLength;
  var keyBoradType;
  TextEditingController controller;

   AddCardTextFeild({required this.title,required this.controller,this.maxLength=16,this.keyBoradType=TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            TextField(
              keyboardType: keyBoradType,
              maxLength: maxLength,

              cursorColor: Colors.black,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              decoration: InputDecoration( counterText: "",focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
