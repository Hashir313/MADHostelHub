import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/hostel_owner/owner_auth/owner_login.dart';
import 'package:hostel_hub/hostel_owner/owner_auth/owner_tab_bar.dart';
import 'package:hostel_hub/hostel_owner/owner_bottom_bar/owner_bottom_bar.dart';
import 'package:hostel_hub/utils/auth_button.dart';
import 'package:hostel_hub/utils/colors.dart';
import 'package:hostel_hub/utils/validators_and_errors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //password visibility
  bool showPassword = true;

  final formKey = GlobalKey<FormState>();

  // Text Editing Controller for email and password
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  int? phone;

// functions for image
  File? image;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            fontSize: 20.0.sp,
            color: AppColors().whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors().secondaryColor,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const OwnerTabBar(),
                  ),
                );
              },
              icon: Icon(
                Icons.logout,
                color: AppColors().whiteColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Center(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('hostelUser')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 10.0.h,
                            backgroundColor: AppColors().primaryColor,
                            backgroundImage: image != null
                                ? FileImage(image!)
                                : NetworkImage(
                              snapshot.data!['imageURL'],
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
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.person,
                                      ),
                                      prefixIconColor:
                                      AppColors().secondaryColor,
                                      hintText: snapshot.data!['username'],
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
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.email,
                                      ),
                                      prefixIconColor:
                                      AppColors().secondaryColor,
                                      hintText: snapshot.data!['email'],
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
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                      ),
                                      prefixIconColor:
                                      AppColors().secondaryColor,
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
                                          color:
                                          AppColors().secondaryColor,
                                        ),
                                      ),
                                      suffixIconColor:
                                      AppColors().secondaryColor,
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
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.phone,
                                      ),
                                      prefixIconColor:
                                      AppColors().secondaryColor,
                                      hintText: snapshot.data!['phone_number'],
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
                            buttonText: 'Update',
                            onTap: () async {
                              // Reset error message
                              Validators.setError(this, '');

                              // Check if any validation fails
                              if (formKey.currentState?.validate() ?? false) {
                                // Upload the image to Firebase Storage
                                String imageName = DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString();
                                firebase_storage.Reference ref =
                                firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child('hostelUserProfile_images/$imageName');
                                await ref.putFile(image!);

                                // Get the download URL after the image is successfully uploaded.
                                String downloadURL = await ref.getDownloadURL();
                                print(downloadURL);

                                await FirebaseFirestore.instance
                                    .collection('hostelUser')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .update({
                                  // 'uid': user.uid,
                                  'username': nameController.text.isEmpty
                                      ? snapshot.data!['username']
                                      : nameController.text,
                                  'email': emailController.text.isEmpty
                                      ? snapshot.data!['email']
                                      : emailController.text,
                                  // 'hashed_password': user.hashedPassword,
                                  'phone_number': phoneController.text.isEmpty
                                      ? snapshot.data!['phone_number']
                                      : phoneController.text,
                                  'imageURL':
                                  (downloadURL == null || downloadURL == '')
                                      ? snapshot.data!['imageURL']
                                      : downloadURL,
                                });
                              }
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('Loading....'),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
