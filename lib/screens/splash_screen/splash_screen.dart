import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/firestore_srevice.dart';
import '../home_screen/home_screen.dart';
import '../my_app_navigator/my_app_navigator.dart';

class SplashFuturePage extends StatefulWidget {
  SplashFuturePage({Key? key}) : super(key: key);

  @override
  _SplashFuturePageState createState() => _SplashFuturePageState();
}

class _SplashFuturePageState extends State<SplashFuturePage> {
  Future<Widget> futureCall() async {
    // do async operation ( api call, auto login)
    await Provider.of<FirestoreService>(context, listen: false).getUserData();


    return Future.value( MyAppNavigator());
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.network(
          'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      backgroundColor: Colors.white,
      showLoader: true,
      futureNavigator: futureCall(),

    );
  }
}