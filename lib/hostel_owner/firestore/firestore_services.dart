import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/user_models.dart';

class FirestoreServices {
  Future<String> uploadImageToStorage(String userId, File image) async {
    try {
      String imagePath = 'profile_images/$userId';
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(imagePath);
      await ref.putFile(image);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error uploading image to storage: $e");
      throw e;
    }
  }

  Future<void> uploadUserData(UserModel user) async {
    try {
      String? userId = user.uid;
      // final CollectionReference usersCollection =
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'uid': user.uid,
        'username': user.username,
        'email': user.email,
        'hashed_password': user.hashedPassword,
        'phone_number': user.phoneNumber,
        'imageURL': user.imageURL,
      });
      // await usersCollection.add(user.toJson());

      print('User data uploaded to Firestore.');
    } catch (e) {
      print('Error uploading user data to Firestore: $e');
    }
  }
  Future<void> uploadHostelUserData(UserModel user) async {
    try {
      String? userId = user.uid;
      // final CollectionReference usersCollection =
      await FirebaseFirestore.instance.collection('hostelUser').doc(userId).set({
        'uid': user.uid,
        'username': user.username,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'imageURL': user.imageURL,
      });
      // await usersCollection.add(user.toJson());

      print('User data uploaded to Firestore.');
    } catch (e) {
      print('Error uploading user data to Firestore: $e');
    }
  }
}

class UserData {
  final String username;
  final String email;
  final String phoneNumber;
  final String imageURL;

  UserData({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.imageURL,
  });

  // Factory method to create UserData from a map
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      imageURL: map['imageURL'] ?? '',
      // Add more properties based on your UserData class
    );
  }
}
