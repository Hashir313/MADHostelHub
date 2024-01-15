import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/hostel_owner/owner_auth/owner_tab_bar.dart';
import 'package:hostel_hub/hostel_user/user_auth/user_tab_bar.dart';
import 'package:hostel_hub/utils/colors.dart';
import 'package:sizer/sizer.dart';

class UserChoiceOption extends StatelessWidget {
  const UserChoiceOption({super.key});

  @override
  Widget build(BuildContext context) {
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
              height: 2.h,
            ),
            Text(
              'Login As:',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OwnerTabBar(),
                  ),
                );
              },
              child: Container(
                height: 9.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: AppColors().secondaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  child: Text(
                    'Hostel Owner',
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 0.2.h,
                  width: 30.w,
                  color: AppColors().secondaryColor,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'OR',
                  style: GoogleFonts.poppins(
                    color: AppColors().secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  height: 0.2.h,
                  width: 30.w,
                  color: AppColors().secondaryColor,
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserTabBar(),
                  ),
                );
              },
              child: Container(
                height: 9.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: AppColors().secondaryColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  child: Text(
                    'Hostel User',
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
