import 'package:check/screens/admin_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  Future signUpUser(String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AdminHomeScreen()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Weak-Password")));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email already exist")));
        print('The account already exists for that email.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future signUserIn(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AdminHomeScreen()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User not found")));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Wrong password")));
        print('Wrong password provided for that user.');
      } else if (e.code == "invalid-credential") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid credentials")));
        print('Invalid credentials');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("An error occurred")));
      }
    }
  }

  Future signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
