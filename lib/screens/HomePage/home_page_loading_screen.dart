import 'package:flutter/material.dart';

class homePageLoadingScreen extends StatelessWidget {
  const homePageLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:Text("Fetching Location..."),),);
  }
}
