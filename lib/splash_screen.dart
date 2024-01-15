import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/user_choice_opt.dart';
import 'package:hostel_hub/utils/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'hostel_owner/owner_bottom_bar/owner_bottom_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check the user's login status
    User? user = FirebaseAuth.instance.currentUser;

    // Delay for 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the appropriate screen based on the user's login status
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
          user != null ? const OwnerBottomBar() : const UserChoiceOption(),
        ),
      );
    });

    return Scaffold(
      backgroundColor: AppColors().primaryColor,
      body: Container(
        height: 100.h,
        width: 100.w,
        margin: EdgeInsets.only(top: 3.h),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5.h),
            Image.asset('assets/images/splash_screen_image.png'),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Hostel Hub',
              style: GoogleFonts.poppins(
                color: AppColors().secondaryColor,
                fontSize: 32.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
