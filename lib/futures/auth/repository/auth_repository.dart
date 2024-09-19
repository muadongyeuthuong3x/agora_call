import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firebase Firestore
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/common/repositories/common_firebase_storage_repository.dart';
import 'package:my_project/common/utils/utils.dart';
import 'package:my_project/futures/auth/screens/otp_screen.dart';
import 'package:my_project/futures/auth/screens/user_information_screen.dart';
import 'package:my_project/futures/models/user_model.dart';
import 'package:my_project/mobile_layout_screen.dart';

// Provider for AuthRepository
final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance)); // Updated to FirebaseFirestore

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore; // Updated type

  AuthRepository({required this.auth, required this.firestore}); // Constructor

  Future<UserModel?> getCurrentUserData() async {
    var userData = await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }

    return user;
  }

void signInWithPhone(BuildContext context, String phoneNumber) async {
  try {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("verificationCompleted callback called");
        print("Credential: $credential");
        try {
          await auth.signInWithCredential(credential);
          // Thành công khi đăng nhập
          print("Sign in successful");
        } catch (e) {
          // Xử lý lỗi khi đăng nhập
          print("Sign in failed: $e");
          showSnackBar(context: context, content: "Sign in failed: $e");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print("verificationFailed callback called");
        print("Error: ${e.message}");
        showSnackBar(context: context, content: e.message!);
        throw Exception(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        print("codeSent callback called");
        print("Verification ID: $verificationId");
        print("Resend Token: $resendToken");
        Navigator.pushNamed(
          context,
          OtpScreen.routeName,
          arguments: verificationId,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("codeAutoRetrievalTimeout callback called");
        print("Verification ID: $verificationId");
      },
    );
  } on FirebaseAuthException catch (e) {
    // Xử lý lỗi trong quá trình gọi verifyPhoneNumber
    print("FirebaseAuthException: ${e.message}");
    showSnackBar(context: context, content: e.message!);
  } catch (e) {
    // Xử lý lỗi không phải FirebaseAuthException
    print("Exception: $e");
    showSnackBar(context: context, content: "An unexpected error occurred: $e");
  }
}

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP
      );
      await auth.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const UserInformationScreen()),
        (route) => false
      );
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      print(auth.currentUser);
      String uid = auth.currentUser!.uid;
      print(uid);
      String photoUrl =
          'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2023/07/anh-dep-thien-nhien-2-1.jpg';
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase('profilePic/$uid', profilePic);
        var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: []
        );
        await firestore.collection('users').doc(uid).set(user.toMap());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileLayoutScreen()),
          (route) => false
        );
      }
    } catch (e) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileLayoutScreen()),
          (route) => false
        );
      print("Error: ${e.toString()}");
      showSnackBar(context: context, content: e.toString());
    }
  }

 Stream<UserModel> userData(String userId){
    return firestore.collection('users').doc(userId).snapshots().map((event) => UserModel.fromMap(event.data()!));
  }
}
