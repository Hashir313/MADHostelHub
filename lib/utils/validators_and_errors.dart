// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hostel_hub/utils/flutter_toast.dart';

class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 7) {
      return 'Password must be at least 7 characters long';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // You can add more specific validation for phone numbers if needed
    return null;
  }

  static void setError(State state, String message) {
    if (state is SetState) {
      state.setState(() {
        errorMessage = message;
      });

      // Show the error message using your FlutterToast implementation
      ToastMessage().flutterToast(message);
    }
  }
}

// Interface for State classes that can call setState
abstract class SetState {
  void setState(VoidCallback fn);
}

String? errorMessage;
