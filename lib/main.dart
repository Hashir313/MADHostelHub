import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_hub/firebase_options.dart';
import 'package:hostel_hub/splash_screen.dart';
import 'package:hostel_hub/utils/colors.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientattion, deviceType) {
      return MaterialApp(
        theme: ThemeData(
          primaryColor: AppColors().primaryColor,
          secondaryHeaderColor: AppColors().primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      );
    });
  }
}
