import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_hub/utils/auth_button.dart';
import 'package:hostel_hub/utils/custom_text_field.dart';
import 'package:hostel_hub/utils/flutter_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors.dart';

class AddHostels extends StatefulWidget {
  const AddHostels({super.key});

  @override
  State<AddHostels> createState() => _AddHostelsState();
}

class _AddHostelsState extends State<AddHostels> {
  TextEditingController hostelNameController = TextEditingController();
  TextEditingController hostelLocationController = TextEditingController();
  TextEditingController hostelAvailableRoomController = TextEditingController();
  TextEditingController hostelRoomTypeController = TextEditingController();
  TextEditingController hostelRoomPriceController = TextEditingController();
  TextEditingController hostelDescriptionController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;


  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source:"),
          actions: [
            TextButton(
              onPressed: () {
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: const Text("Gallery"),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _uploadImage() async {
    try {
      String imagePath = 'hostel_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask task = _storage.ref().child(imagePath).putFile(_selectedImage!);
      TaskSnapshot snapshot = await task;

      // Get the download URL of the uploaded image
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  // Function to add hostel data to Firestore
  Future<void> _addHostelToFirestore(String imageUrl) async {
    try {
      // Get the user ID (assuming you have a user authentication system)
      String userId = _auth.currentUser?.uid ?? '';

      // Add hostel data to Firestore
      await _firestore.collection('hostelDetails').add({
        'userId': userId,
        'hostelName': hostelNameController.text,
        'hostelLocation': hostelLocationController.text,
        'hostelAvailableRooms': int.parse(hostelAvailableRoomController.text),
        'hostelRoomType': hostelRoomTypeController.text,
        'hostelRoomPrice': double.parse(hostelRoomPriceController.text),
        'hostelDescription': hostelDescriptionController.text,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ToastMessage().flutterToast('Hostel added to Firestore successfully!');
    } catch (e) {
      ToastMessage().flutterToast('Error adding hostel to Firestore: $e');
    }
  }

  // Function to handle the "Upload Hostel" button tap
  Future<void> _handleUploadHostel() async {
    if (_selectedImage != null) {
      // Upload image to Firebase Storage
      String? imageUrl = await _uploadImage();

      if (imageUrl != null) {
        // Add hostel data to Firestore
        await _addHostelToFirestore(imageUrl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: AppColors().primaryColor.withOpacity(0.1),
          appBar: AppBar(
            title: Text(
              'Add Hostels',
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
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Enter Your Hostel Details',
                      style: GoogleFonts.poppins(
                        fontSize: 20.0.sp,
                        color: AppColors().secondaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: CustomTextField(
                        editingController: hostelNameController,
                        prefixIcon: const Icon(Icons.hotel_rounded),
                        hintText: 'Enter your hostel name',
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: CustomTextField(
                        editingController: hostelLocationController,
                        prefixIcon: const Icon(Icons.location_on),
                        hintText: 'Enter your hostel location',
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: CustomTextField(
                        editingController: hostelAvailableRoomController,
                        prefixIcon: const Icon(Icons.meeting_room),
                        hintText: 'Enter number of available rooms',
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: CustomTextField(
                        editingController: hostelRoomTypeController,
                        prefixIcon: const Icon(Icons.room_service),
                        hintText: 'Enter room type',
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: CustomTextField(
                        editingController: hostelRoomPriceController,
                        prefixIcon: const Icon(Icons.price_change_outlined),
                        hintText: 'Enter room price',
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 90.w,
                      child: TextField(
                        controller: hostelDescriptionController,
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
                          prefixIcon: const Icon(Icons.description),
                          prefixIconColor: AppColors().secondaryColor,
                          hintText: 'Enter the hostel description',
                          hintStyle: GoogleFonts.poppins(),
                          alignLabelWithHint: true,
                        ),
                        textInputAction: TextInputAction.next,
                        maxLines: 5,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InkWell(
                      onTap: () {
                        _showImageSourceDialog(context);
                      },
                      child: Container(
                        width: 200.w,
                        height: 30.h,
                        decoration: _selectedImage == null
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              )
                            : null,
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.fill,
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey,
                                      size: 5.h,
                                    ),
                                    Text(
                                      'Upload Image Here',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    AuthCustomButton(
                      buttonText: 'Upload Hostel',
                      onTap: _handleUploadHostel,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
