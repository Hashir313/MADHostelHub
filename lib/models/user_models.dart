class UserModel {
  final String username;
  final String email;
  final String hashedPassword;
  final String phoneNumber;
  final String imageURL;
  final String? uid;

  UserModel({
    this.uid,
    required this.username,
    required this.email,
    required this.hashedPassword,
    required this.phoneNumber,
    required this.imageURL,
  });

  // Method to create a user object from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      email: json['email'],
      hashedPassword: json['hashed_password'],
      phoneNumber: json['phone_number'],
      imageURL: json['imageURL'],
    );
  }

  // Method to convert user object to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'hashed_password': hashedPassword,
      'phone_number': phoneNumber,
      'imageURL': imageURL,
    };
  }
}
