import 'package:flutter/material.dart';
import 'package:hostel_hub/hostel_user/user_screens/user_hostel_list.dart';
import 'package:hostel_hub/hostel_user/user_screens/user_profile.dart';
import 'package:hostel_hub/utils/colors.dart';
import 'package:sizer/sizer.dart';

class UserBottomBar extends StatefulWidget {
  const UserBottomBar({super.key});

  @override
  State<UserBottomBar> createState() => _UserBottomBarState();
}

class _UserBottomBarState extends State<UserBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const UserHostelList(),
    const UserProfile(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _pages[_selectedIndex],
      floatingActionButton: Padding(
        padding: EdgeInsets.all(2.h),
        child: Container(
          height: 7.h,
          width: 80.w,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.0, -.5),
              end: const Alignment(0, 2),
              colors: [AppColors().secondaryColor, AppColors().primaryColor],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                splashColor: AppColors().secondaryColor.withOpacity(0.1),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: SizedBox(
                  height: 8.h,
                  width: 15.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.list),
                      _selectedIndex == 0
                          ? SizedBox(
                              height: 1.h,
                            )
                          : Container(),
                      _selectedIndex == 0 ? const GreenLine() : Container()
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: AppColors().secondaryColor.withOpacity(0.1),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: SizedBox(
                  height: 8.h,
                  width: 15.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_circle_outlined),
                      _selectedIndex == 1
                          ? SizedBox(
                              height: 1.h,
                            )
                          : Container(),
                      _selectedIndex == 1 ? const GreenLine() : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class GreenLine extends StatelessWidget {
  const GreenLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.w,
      height: 1.w,
      decoration: BoxDecoration(
        color: AppColors().whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
