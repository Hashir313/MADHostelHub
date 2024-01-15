import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/utils/colors.dart';

class AuthCustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;
  final bool loading;

  const AuthCustomButton({
    super.key,
    required this.buttonText,
    this.loading = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.06,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: AppColors().secondaryColor,
          borderRadius: BorderRadius.circular((16.0)),
        ),
        child: Center(
          child: Text(buttonText,
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: AppColors().whiteColor,
              )),
        ),
      ),
    );
  }
}
