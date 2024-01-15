import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/hostel_owner/owner_bottom_bar/owner_bottom_bar.dart';
import 'package:hostel_hub/utils/auth_button.dart';
import 'package:hostel_hub/utils/colors.dart';
import 'package:hostel_hub/utils/flutter_toast.dart';
import 'package:sizer/sizer.dart';

class OwnerLogin extends StatefulWidget {
  const OwnerLogin({super.key});

  @override
  State<OwnerLogin> createState() => _OwnerLoginState();
}

class _OwnerLoginState extends State<OwnerLogin> {
  ToastMessage y = ToastMessage();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  // password visibility
  bool showPassword = true;

  Future<void> login() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        await _auth
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
            .then((value) {
          ToastMessage().flutterToast('Signed in Successfully');
          emailController.clear();
          passwordController.clear();

          // Remove the ability to go back to the login screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OwnerBottomBar(),
            ),
          );
        }).onError((error, stackTrace) {
          ToastMessage().flutterToast(error.toString());
        });
      }
    } catch (e) {
      ToastMessage().flutterToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 80.w,
                  child: Material(
                    shadowColor: AppColors().secondaryColor,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(15.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
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
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        prefixIconColor: AppColors().secondaryColor,
                        hintText: 'Email',
                        hintStyle: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 80.w,
                  child: Material(
                    shadowColor: AppColors().secondaryColor,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(15.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: showPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
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
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        prefixIconColor: AppColors().secondaryColor,
                        suffixIcon: showPassword
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: const Icon(
                                  Icons.visibility_off,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: const Icon(
                                  Icons.visibility,
                                ),
                              ),
                        suffixIconColor: AppColors().secondaryColor,
                        hintText: 'Password',
                        hintStyle: GoogleFonts.figtree(),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        color: AppColors().secondaryColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                AuthCustomButton(
                  buttonText: 'Login',
                  onTap: () => login(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1.5,
                width: 100,
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
                height: 1.5,
                width: 100,
                color: AppColors().secondaryColor,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            'Login With?',
            style: GoogleFonts.poppins(
              color: AppColors().secondaryColor,
              fontSize: 12.sp,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors().secondaryColor,
                  ),
                  child: Image.asset(
                    'assets/images/fb_logo.png',
                    height: 20.0,
                    width: 20.0,
                    color: AppColors().whiteColor,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              InkWell(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors().secondaryColor,
                  ),
                  child: Image.asset(
                    'assets/images/google_logo.png',
                    height: 20.0,
                    width: 20.0,
                    // color: AppColors().whiteColor,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
