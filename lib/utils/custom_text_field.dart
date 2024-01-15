import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editingController;
  final Icon prefixIcon;
  final String hintText;

  const CustomTextField(
      {super.key,
      required this.editingController,
      required this.prefixIcon,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your hostel name';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors().whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors().secondaryColor,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(),
      ),
    );
  }
}
