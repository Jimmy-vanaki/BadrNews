import 'dart:async';

import 'package:badrnews/constants/constants.dart';
import 'package:badrnews/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          duration: const Duration(seconds: 2),
          reverseDuration: const Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Constants.themeColor,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              './Assets/images/logo-bn.png',
              fit: BoxFit.cover,
              width: 250,
            ),
          ),
          const Positioned(
            bottom: 200,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
