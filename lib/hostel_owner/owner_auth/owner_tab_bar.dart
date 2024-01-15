import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/hostel_owner/owner_auth/owner_login.dart';
import 'package:hostel_hub/hostel_owner/owner_auth/owner_signup.dart';
import 'package:hostel_hub/utils/colors.dart';
import 'package:sizer/sizer.dart';

class OwnerTabBar extends StatefulWidget {
  const OwnerTabBar({super.key});

  @override
  State<OwnerTabBar> createState() => _OwnerTabBarState();
}

class _OwnerTabBarState extends State<OwnerTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Hostel Owners',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: AppColors().secondaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 5.h),
          child: Column(
            children: [
              Container(
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: AppColors().secondaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors().secondaryColor,
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Login'),
                    Tab(text: 'Sign Up'),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    OwnerLogin(),
                    OwnerSignup(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
