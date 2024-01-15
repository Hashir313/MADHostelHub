import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/utils/booking_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors.dart';

class HostelDescription extends StatefulWidget {
  final String hostelId;

  const HostelDescription({Key? key, required this.hostelId}) : super(key: key);

  @override
  State<HostelDescription> createState() => _HostelDescriptionState();
}

class _HostelDescriptionState extends State<HostelDescription> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Hostel Details',
            style: GoogleFonts.poppins(
              fontSize: 20.0.sp,
              color: AppColors().whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors().secondaryColor,
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BookingDialog(
                      // Pass necessary parameters to BookingDialog if required
                      );
                },
              ).then((value) {
                // After BookingDialog is closed, show another dialog for confirmation
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Booking Confirmed'),
                      content: Text('Your booking has been confirmed!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              });
            },
            child: const Text(
              'Book Hostel',
            ),
          ),
        ));
  }
}
