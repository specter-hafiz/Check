import 'package:check/utilities/dialogs/error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DBProvider extends ChangeNotifier {
  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location services are disabled.')));
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
              "No Internet', 'Please check your internet connection and try again.")));
      return;
    }
  }

  Future<void> setAttendance(
    String title,
    String creatorName,
    int attendeesN,
    String password,
    BuildContext context,
  ) async {
    _checkConnectivity(context);

    // Determine the creator's position
    Position creatorPosition = await _determinePosition(context);
    GeoPoint creatorLocation = GeoPoint(
      creatorPosition.latitude,
      creatorPosition.longitude,
    );

    // Get the current user
    User user = FirebaseAuth.instance.currentUser!;
    DateTime date = DateTime.now();

    try {
      bool isPasswordUnique = await _isPasswordUnique(password);
      if (!isPasswordUnique) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Password already exists. Please choose another.")),
        );
        return;
      }
      // Create the attendance document
      CollectionReference attendance = FirebaseFirestore.instance
          .collection("attendance")
          .doc(user.uid)
          .collection("attendances");
      DocumentReference ref = await attendance.add({
        "user_id": user.uid,
        "creator_name": creatorName,
        "title": title,
        "creator_loc": creatorLocation,
        "number": attendeesN,
        "password": password,
        "created_at": date.toIso8601String(),
      });

      // Update the attendance document with its document ID
      await attendance.doc(ref.id).update({"doc_id": ref.id});

      // Create the corresponding password document
      DocumentReference passwordDocRef =
          FirebaseFirestore.instance.collection("passwords").doc();
      await passwordDocRef.set({
        "user_id": user.uid,
        "attendance_password": password,
        "creator_name": creatorName,
        "ref_id": ref.id,
        "doc_id": passwordDocRef.id,
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Attendance setting successful")),
      );
    } catch (e) {
      // Show an error message if setting attendance fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to set attendance")),
      );
      print("Error setting attendance: $e");
    }
  }

  Future<void> deleteAttendance(
      BuildContext context, String userId, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection("attendance")
          .doc(userId)
          .collection("attendances")
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Attendance deleted successfully")),
      );
    } catch (e) {
      await showErrorDialog(context, "Attendance deletion unsuccessful");
    }
  }

  Future<void> signAttendance(
    String name,
    String idNumber,
    BuildContext context,
    String userId,
    String password,
  ) async {
    _checkConnectivity(context);

    // Determine the creator's position
    Position creatorPosition = await _determinePosition(context);
    GeoPoint attendeeLocation = GeoPoint(
      creatorPosition.latitude,
      creatorPosition.longitude,
    );

    // Get the current date and time
    DateTime date = DateTime.now();

    // Query the passwords collection to find matching attendance documents
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('passwords')
        .where('attendance_password', isEqualTo: password)
        .get();

    // Handle signing attendance for each matching document
    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        String refId = documentSnapshot["ref_id"];
        CollectionReference attendance = FirebaseFirestore.instance
            .collection("attendance")
            .doc(userId)
            .collection("attendances")
            .doc(refId)
            .collection("attendancesheet");

        try {
          bool isIdNumberUnique =
              await _isIdNumberUniqueInAttendanceSheet(attendance, idNumber);
          if (!isIdNumberUnique) {
            // If ID number already exists, show a message and skip signing
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("ID number already signed attendance")),
            );
            continue;
          }
          // Add a new attendance record
          DocumentReference ref = await attendance.add({
            "name": name,
            "id_number": idNumber,
            "signed_at": date.toIso8601String(),
            "location": attendeeLocation,
          });

          // Update the newly added record with its document ID
          await attendance.doc(ref.id).update({
            "doc_id": ref.id,
          });

          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Attendance recorded successfully")),
          );
        } catch (e) {
          // Show an error message if adding the attendance fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to record attendance")),
          );
          print("Error adding attendance: $e");
        }
      }
    } else {
      // Show a message if no matching attendance documents are found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No matching attendance found")),
      );
    }
  }
}

Future<bool> _isPasswordUnique(String password) async {
  try {
    // Query the passwords collection to check if the password already exists
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("passwords")
        .where("attendance_password", isEqualTo: password)
        .get();

    // If no documents match the query, then the password is unique
    return querySnapshot.docs.isEmpty;
  } catch (e) {
    // Handle any potential errors, such as network issues or database errors
    print("Error checking password uniqueness: $e");
    return false; // Consider it not unique in case of error
  }
}

Future<bool> _isIdNumberUniqueInAttendanceSheet(
    CollectionReference attendance, String idNumber) async {
  try {
    // Query the attendance sheet to check if the ID number already exists
    QuerySnapshot querySnapshot =
        await attendance.where('id_number', isEqualTo: idNumber).get();

    // If no documents match the query, then the ID number is unique
    return querySnapshot.docs.isEmpty;
  } catch (e) {
    // Handle any potential errors, such as network issues or database errors
    print("Error checking ID number uniqueness in attendance sheet: $e");
    return false; // Consider it not unique in case of error
  }
}
