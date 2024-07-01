import 'package:anantkaal/utils/constant/const_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
  Future<void> _signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup Successful!')));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = 'An unknown error occurred.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred. Please try again.')));
    }
  }
  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //     final User? user = userCredential.user;
  //
  //     // Use the user object for further operations or navigate to a new screen.
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google sign-in canceled')));
        return;
      }
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign In with Google Successful!')));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'account-exists-with-different-credential') {
        message = 'The account already exists with a different credential.';
      } else if (e.code == 'invalid-credential') {
        message = 'The provided credential is invalid.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Google sign-in is not enabled.';
      } else if (e.code == 'user-disabled') {
        message = 'The user has been disabled.';
      } else if (e.code == 'user-not-found') {
        message = 'The user was not found.';
      } else if (e.code == 'wrong-password') {
        message = 'The password is incorrect.';
      } else {
        message = 'An unknown error occurred.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An unknown error occurred. Please try again.')));
      print(e); // Add logging to help debug issues
    }
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = _emailFocusNode.hasFocus ? kPrimaryColor : Colors.grey;
    Color borderColorpass = _passwordFocusNode.hasFocus ? kPrimaryColor : Colors.grey;
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: _emailFocusNode.hasFocus ? Color(0xffDDEFF0) : Colors.white,
                border: Border.all(
                  color: borderColor,
                  width: _emailFocusNode.hasFocus ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: _emailFocusNode.hasFocus ? Color(0xffBFE0E2) : Colors.white,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: TextField(
                style: GoogleFonts.exo(
                  textStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                ),
                focusNode: _emailFocusNode,
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter ur email",
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: _passwordFocusNode.hasFocus ? Color(0xffDDEFF0) : Colors.white,
                border: Border.all(
                  color: borderColorpass,
                  width: _passwordFocusNode.hasFocus ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: _passwordFocusNode.hasFocus ? Color(0xffBFE0E2) : Colors.white,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: TextField(
                style: GoogleFonts.exo(
                  textStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                ),
                focusNode: _passwordFocusNode,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter ur password",
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
