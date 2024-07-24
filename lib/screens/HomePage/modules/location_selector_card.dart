import 'package:flutter/material.dart';

class LocationSelectorCard extends StatelessWidget {
  String title="";
  String value="";
  Color titleColor=Colors.redAccent;
  dynamic onTap=(){};
  int maxline;
 LocationSelectorCard({this.title="", required this.value, required this.titleColor,this.onTap,this.maxline=1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          title==""?SizedBox():Text(title,style: TextStyle(fontSize: 12,color: titleColor),),
          Expanded(child: Align(alignment:Alignment.centerLeft,child: Text(value,style: TextStyle(fontSize: 14,color: Colors.black),maxLines: maxline,overflow: TextOverflow.ellipsis,)))

        ],
      ),
    );
  }
}
