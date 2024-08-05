import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_meeting_msp/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';

class MyAppNavigator extends StatelessWidget {
  const MyAppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if (snapshot.hasData){
              return  HomeScreen();
            }
            if (snapshot.connectionState==ConnectionState.waiting){
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.hasError){
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return LoginScreen();
          },
        )
    );
  }
}
