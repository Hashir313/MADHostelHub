import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/hostel_user/user_screens/HostelDescription.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors.dart';

class UserHostelList extends StatefulWidget {
  const UserHostelList({super.key});

  @override
  State<UserHostelList> createState() => _UserHostelListState();
}

class _UserHostelListState extends State<UserHostelList> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sample hostel data (replace this with your logic to fetch data from Firestore)
  String hostelImage =
      'https://th.bing.com/th?id=OIP.wuMtUwCzCJGB8rYWLyfqlwHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2';
  String hostelName = 'Hostel Name';
  String hostelLocation = 'Hostel Location';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hostels List',
          style: GoogleFonts.poppins(
            fontSize: 20.0.sp,
            color: AppColors().whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors().secondaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Available Hostels:',
                    style: GoogleFonts.poppins(
                      color: AppColors().secondaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                FutureBuilder(
                  future: _firestore.collection('hostelDetails').get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      var hostelData = snapshot.data!.docs;
                      return Column(
                        children: hostelData.map((hostel) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 5.0.h),
                            child: Material(
                              elevation: 10.0,
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: AppColors().secondaryColor,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) =>
                                           HostelDescription(hostelId: hostel['userId'],),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    color: AppColors()
                                        .primaryColor
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 23.h,
                                        width: 90.h,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                hostel['imageUrl']),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.w, top: 2.h, right: 2.w),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            hostel['hostelName'],
                                            style: GoogleFonts.poppins(
                                                fontSize: 20.0.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors().whiteColor),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 2.w,
                                          bottom: 2.h,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            hostel['hostelLocation'],
                                            style: GoogleFonts.poppins(
                                                fontSize: 16.0.sp,
                                                color: AppColors().whiteColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
