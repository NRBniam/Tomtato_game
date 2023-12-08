/// This is for the Quiz's Page

// Import necessary packages for Firebase authentication and Riverpod state management.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a provider for the authentication controller.
final authprovider = Provider((ref) => AuthProvider());

// Class responsible for authentication purposes.
class AuthProvider {
  // Method for user login using Firebase authentication.
  Future<String> userlogin(String email, String password) async {
    try {
      // Attempt to sign in with the provided email and password.
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // Return a success message if login is successful.
      return "Successful";
    } on AsyncLoading {
      // Return a loading message (Note: AsyncLoading should be handled properly in the future).
      return "Loading..";
    } on FirebaseAuthException catch (error) {
      // Return the error message if login fails.
      return "$error";
    }
  }

  // Method for user signup using Firebase authentication.
  Future<String> userSignup(String email, String password) async {
    try {
      // Attempt to create a new user with the provided email and password.
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // Return a success message if signup is successful.
      return "Successful";
    } on AsyncLoading {
      // Return a loading message (Note: AsyncLoading should be handled properly in the future).
      return "Loading..";
    } on FirebaseAuthException catch (error) {
      // Return the error message if signup fails.
      return "$error";
    }
  }
}
