// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class FirebaseAuthentication{
//   FirebaseAuth firebaseAuth=FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//
//   Future<User?> signWithGoogle()async{
//     try{
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         return null; // User cancelled the sign-in process
//       }
//
//       // Obtain the Google authentication details
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       // Create a new credential
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       // Sign in to Firebase using the Google credential
//       final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
//       return userCredential.user;
//     }
//     catch(e){
//       print(e);
//       return null;
//     }
//   }
//
//   Future<void> signOut()async{
//     await _googleSignIn.signOut();
//     return await firebaseAuth.signOut();
//   }
//
//   Future<void> signInWithOtp(String number,Function(String verificationId, int? forceResendingToken) codeSent)async{
//     try{
//       print(number);
//       final result=await firebaseAuth.verifyPhoneNumber(
//         phoneNumber: "+91$number",
//         verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  },
//         verificationFailed: (FirebaseAuthException error) {  },
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: (String verificationId) {  },
//       );
//     }catch(e){
//       print(e);
//     }
//   }
//
//   Future<bool> verifyOTP(String verificationId,String otp) async {
//     final credential = PhoneAuthProvider.credential(
//       verificationId:verificationId,
//       smsCode: otp,
//     );
//
//     try {
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       return true;
//       // Handle successful login
//     } catch (e) {
//       print(e);
//       return false;
//       // Handle error (e.g., invalid OTP)
//     }
//   }
//
//   Future<UserCredential?> signInWithEmailPassword(String email, String password)async{
//     try{
//       final credential= await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//       return credential;
//     }catch(e){
//       print(e);
//       return null;
//     }
//   }
// }