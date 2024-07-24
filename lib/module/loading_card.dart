import 'package:ambulance_test/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    var color=Color(0xFFACADAE);
    return SizedBox(height: 100,width: ScreenSize.w,
        child: Shimmer.fromColors(
          baseColor: ConstColor.DarkGrey,
          highlightColor: Colors.white,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 80,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: color),),
            ),
            Expanded(child: Column(
              children: [
                Expanded(child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: color),),
                ) ),
                Expanded(child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: color),),
                ) ),
              ],
            )
            ),
          ],),
        ),
    );
  }
}
