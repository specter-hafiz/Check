import 'package:check/screens/admin_home_screen.dart';
import 'package:check/screens/attendee_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AttendanceVerificationResult {
  final String creatorName;
  final String docId;

  AttendanceVerificationResult(this.creatorName, this.docId);
}

class AuthProvider extends ChangeNotifier {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _checkConnectivity(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "No Internet,please check your internet connection and try again.")));
      return;
    }
  }

  Future signUpUser(String email, String password, BuildContext context) async {
    _checkConnectivity(context);
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
    _checkConnectivity(context);
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

  Future signUserOut(BuildContext context) async {
    _checkConnectivity(context);
    await FirebaseAuth.instance.signOut();
  }

  Future<void> verifyAttendance(BuildContext context, String password,
      String user, String idNumber) async {
    // Check if location service is enabled for the attendee
    await _determinePosition();

    _checkConnectivity(context);

    // Query Firestore for the attendance record with the provided password
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('attendance')
          .where('password', isEqualTo: password)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String creatorName = documentSnapshot["creatorName"];

          String docid = documentSnapshot["doc_id"];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AttendeeHomeScreen(
                        user: user,
                        idNumber: idNumber,
                        creatorName: creatorName,
                        docId: docid,
                      )));
        }
      }

      // Check if attendance record exists
      else {
        // Attendance not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid password or Attendance not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred')),
      );
    }
  }
}
