import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_meeting_msp/screens/splash_screen/splash_screen.dart';
import 'package:firebase_meeting_msp/services/auth_service.dart';
import 'package:firebase_meeting_msp/services/firestore_srevice.dart';
import 'package:firebase_meeting_msp/services/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// localization
// storage

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginProvider>(create: (context) => LoginProvider()),
      ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
      ChangeNotifierProvider<FirestoreService>(create: (context) => FirestoreService()),
    ],


      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:SplashFuturePage(),
    );
  }
}

