import 'package:check/screens/admin_home_screen.dart';
import 'package:check/screens/attendee_home_screen.dart';
import 'package:check/screens/verify_email_screen.dart';
import 'package:check/utilities/dialogs/error_dialog.dart';
import 'package:check/utilities/dialogs/success_dailog.dart';
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

  Future<bool> _checkConnectivity(BuildContext context) async {
    var connectivity = Connectivity();

    // Check initial connectivity status
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      final snackBar = SnackBar(
        content: Text(
            "No Internet, please check your internet connection and try again."),
        // Persistent duration
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false; // Return false if no internet connection
    }

    // Listen for changes in connectivity status
    connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        final snackBar = SnackBar(
          content: Text(
              "No Internet, please check your internet connection and try again."),
          // Persistent duration
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    return true; // Return true if internet connection is available
  }

  Future signUpUser(String username, String email, String password,
      BuildContext context) async {
    _checkConnectivity(context);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send verification email
      await userCredential.user!.sendEmailVerification();

      // Redirect to VerifyEmailScreen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => VerifyEmailScreen(
          userEmail: email,
        ),
      ));

      // Listen to auth state changes to navigate to AdminHomeScreen
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null && user.emailVerified) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                AdminHomeScreen(currentUser: user.displayName ?? "unknown"),
          ));
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Weak password")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email already exists")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Check internet connection and try again")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("An unknown error occurred")));
    }
  }

  Future signUserIn(
      String emailAddress, String password, BuildContext context) async {
    try {
      await _checkConnectivity(context);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      User? user = userCredential.user;

      // Check if email is verified
      if (user != null && user.emailVerified) {
        // Navigate to AdminHomeScreen
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              AdminHomeScreen(currentUser: user.displayName ?? "unknown"),
        ));
      } else {
        // Send verification email
        await user!.sendEmailVerification();

        // Navigate to VerifyEmailScreen
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => VerifyEmailScreen(
            userEmail: emailAddress,
          ),
        ));
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth exceptions
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User not found")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Wrong password")));
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid credentials")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Check internet connection and try again")));
      }
    } catch (e) {
      // Handle other exceptions
      print("An unknown error occurred");
      print(e.toString());
    }
  }

  Future signUserOut(BuildContext context) async {
    _checkConnectivity(context);
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/welcome", (route) => false);
    } catch (e) {
      print("Failed.Couldn't sign user out");
    }
  }

  Future<void> verifyAttendance(
    BuildContext context,
    String password,
    String user,
    String idNumber,
    TextEditingController namecontroller,
    TextEditingController idcontroller,
    TextEditingController passwordcontroller,
  ) async {
    // Check if location service is enabled for the attendee

    // Query Firestore for the attendance record with the provided password
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No internet connection')),
      );
      return; // Exit function if there is no internet connection
    }
    try {
      // Initialize Firebase app (if not already initialized)

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('passwords')
          .where('attendance_password', isEqualTo: password)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String creatorName = documentSnapshot["creator_name"];
          String userId = documentSnapshot["user_id"];
          String docid = documentSnapshot["doc_id"];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AttendeeHomeScreen(
                user: user,
                idNumber: idNumber,
                creatorName: creatorName,
                docId: docid,
                userId: userId,
                password: password,
              ),
            ),
          );
          namecontroller.clear();
          idcontroller.clear();
          passwordcontroller.clear();
        }
      } else {
        // Attendance not found
        await showErrorMessage(
            context,
            'Wrong password or Attendance sheet does not exist',
            "Attendance Sheet");
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        // Handle network unavailable error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Network unavailable. Please check your internet connection.')),
        );
      } else {
        // Handle other Firestore exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Firestore error: ${e.message}')),
        );
      }
    } catch (e) {
      // Handle other unknown errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred')),
      );
    }
  }

  Future<void> sendResetPasswordLink(BuildContext context, String email,
      TextEditingController controller) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Password reset email sent successfully
      controller.clear();
      showSuccessMessage(
          context,
          "An reset password link has been sent to this email " + email,
          "Email");
    } catch (e) {
      // Handle errors
      showErrorMessage(
          context,
          "Sorry, we are unable to send you a reset link.Try again later",
          "Email");
      print("Error sending password reset email: $e");
    }
  }
}
