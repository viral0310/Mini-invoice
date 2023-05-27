import 'dart:async';

import 'package:flutter/material.dart';

import '../constatnt/Global.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  initState() {
    super.initState();

    Duration duration = const Duration(seconds: 3);
    Timer(duration, () {
      Navigator.of(context).pushReplacementNamed('/main_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon.png",
              height: 120,
              width: 120,
              //color: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              Global.app_Name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
