import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/hostel_owner/firestore/firestore_services.dart';
import 'package:hostel_hub/models/user_models.dart';
import 'package:hostel_hub/utils/auth_button.dart';
import 'package:hostel_hub/utils/colors.dart';
import 'package:hostel_hub/utils/flutter_toast.dart';
import 'package:hostel_hub/utils/validators_and_errors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  //password visibility
  bool showPassword = true;

  final formKey = GlobalKey<FormState>();

  // Text Editing Controller for email and password
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

// functions for image
  File? image;

  @override
  Widget build(BuildContext context) {
    Future<void> getImage(ImageSource source) async {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        setState(() {
          image = File(pickedImage.path);
        });
      }
    }

    Future<void> signUp() async {
      if (formKey.currentState?.validate() ?? false) {
        try {
          if (image != null) {
            // Upload the image to Firebase Storage
            String imageName = DateTime.now().microsecondsSinceEpoch.toString();
            firebase_storage.Reference ref = firebase_storage
                .FirebaseStorage.instance
                .ref()
                .child('hostelUserProfile_images/$imageName');
            await ref.putFile(image!);

            // Get the download URL after the image is successfully uploaded.
            String downloadURL = await ref.getDownloadURL();

            // Signup with email and password
            UserCredential userCredential =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

            // Create a user object
            UserModel user = UserModel(
                username: nameController.text,
                email: emailController.text,
                hashedPassword: passwordController.text,
                phoneNumber: phoneController.text,
                imageURL: downloadURL,
                uid: userCredential.user?.uid
            );

            // Upload user data to Firestore using the FirestoreService
            await FirestoreServices().uploadHostelUserData(user);


            // Display a success message or navigate to the next screen
            ToastMessage().flutterToast("User registered successfully!");
          } else {
            Validators.setError(this, 'Please select an image.');
          }
        } catch (e) {
          debugPrint('Error during signup or uploading data: ${e.toString()}');
          // Handle errors here, such as displaying an error message to the user.
        }
      }
    }

    void showImagePickerDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            titleTextStyle: GoogleFonts.poppins(
              color: AppColors().secondaryColor,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w600,
            ),
            title: const Text(
              'Choose Image Source',
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors().primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.camera);
                },
                child: Text(
                  'Camera',
                  style: GoogleFonts.poppins(
                    fontSize: 12.0.sp,
                    color: AppColors().whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors().secondaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.gallery);
                },
                child: Text(
                  'Gallery',
                  style: GoogleFonts.poppins(
                    fontSize: 12.0.sp,
                    color: AppColors().whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 10.0.h,
                    backgroundColor: AppColors().primaryColor,
                    backgroundImage: image != null
                        ? FileImage(image!)
                        : const NetworkImage(
                      'https://th.bing.com/th/id/R.47852b09eef32005d40b41e3533f61bf?rik=TfbKJbG%2f0C%2boFQ&pid=ImgRaw&r=0',
                    ) as ImageProvider,
                    child: InkWell(
                      onTap: () {
                        showImagePickerDialog(context);
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 3.h,
                          backgroundColor: AppColors().secondaryColor,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Column(
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Material(
                          shadowColor: AppColors().secondaryColor,
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: TextFormField(
                            validator: Validators.validateName,
                            controller: nameController,
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
                                Icons.person,
                              ),
                              prefixIconColor: AppColors().secondaryColor,
                              hintText: 'Full Name',
                              hintStyle: GoogleFonts.figtree(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Material(
                          shadowColor: AppColors().secondaryColor,
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: TextFormField(
                            controller: emailController,
                            validator: Validators.validateEmail,
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
                              hintStyle: GoogleFonts.figtree(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Material(
                          shadowColor: AppColors().secondaryColor,
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: TextFormField(
                            controller: passwordController,
                            validator: Validators.validatePassword,
                            obscureText: showPassword,
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
                                icon: Icon(
                                  Icons.visibility,
                                  color: AppColors().secondaryColor,
                                ),
                              ),
                              suffixIconColor: AppColors().secondaryColor,
                              hintText: 'Password',
                              hintStyle: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Material(
                          shadowColor: AppColors().secondaryColor,
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: TextFormField(
                            controller: phoneController,
                            validator: Validators.validatePhone,
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
                                Icons.phone,
                              ),
                              prefixIconColor: AppColors().secondaryColor,
                              hintText: 'Phone Number',
                              hintStyle: GoogleFonts.figtree(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  AuthCustomButton(
                    buttonText: 'Sign up',
                    onTap: () async {
                      // Reset error message
                      Validators.setError(this, '');

                      // Check if any validation fails
                      if (formKey.currentState?.validate() ?? false) {
                        await signUp();
                      }
                    },
                  ),
                  SizedBox(
                    height: 5.h,
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
                    height: 5.h,
                  ),
                  Text(
                    'Signup With?',
                    style: GoogleFonts.poppins(
                      color: AppColors().secondaryColor,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
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
                      SizedBox(
                        width: 5.0.w,
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
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
