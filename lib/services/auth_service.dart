import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String country,
    required String state,
    required String city,
    required String postalCode,
    required DateTime? dateOfBirth,
    required String gender,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'address': address,
          'country': country,
          'state': state,
          'city': city,
          'postalCode': postalCode,
          'dateOfBirth': dateOfBirth?.toIso8601String(),
          'gender': gender,
        });
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }
}
