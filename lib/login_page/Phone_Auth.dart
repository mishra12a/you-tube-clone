import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendOTPcode(String phoneNo, Function(String) oncodesent) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          oncodesent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: Duration(seconds: 40));
  }

  Future<String> verifyOTPcode(
      {required String verifyID, required String otp}) async {
    try {
      final PhoneAuthCredential authCredential =
          PhoneAuthProvider.credential(verificationId: verifyID, smsCode: otp);
      final UserCredential userCredential =
          await _auth.signInWithCredential(authCredential);
      if (userCredential.user != null) {
        print("sucessfully signed");
        return 'success';
      } else {
        print("Failed signed error in otp");
        return 'Error in OTP';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> storenumber({
    required String Phone_number,
    required String user_id,
    required String fcm,
  }) async {
    try {
      await _firestore.collection("/Client_ID's").doc().set({
        'Phone_number': Phone_number,
        'user_name': user_id,
        'fcm_token': fcm
      });
    } catch (e) {
      e.toString();
    }
  }
}
