import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/HomeScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
          () {
        Get.to(HomeScreen());
      },
    );

    return Scaffold(
      backgroundColor: Color(0xffec2313),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 750,
              width: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/download.jpeg'),
                      fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }
}