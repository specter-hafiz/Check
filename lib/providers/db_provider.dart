import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DBProvider extends ChangeNotifier {
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
    Position creatorPosition = await _determinePosition();
    GeoPoint creatorLocation =
        GeoPoint(creatorPosition.latitude, creatorPosition.longitude);

    User user = FirebaseAuth.instance.currentUser!;
    DateTime date = DateTime.now();
    try {
      CollectionReference attendance =
          FirebaseFirestore.instance.collection("attendance");
      DocumentReference ref = await attendance.add({
        "user_id": user.uid,
        "creator_name": creatorName,
        "title": title,
        "creator_loc": creatorLocation,
        "number": attendeesN,
        "password": password,
        "created_at": date.toIso8601String(),
      });
      await attendance.doc(ref.id).update({"doc_id": ref.id});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Attendance setting successful")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to set attendance")),
      );
    }
  }

  Future<void> signAttendance(
    String name,
    String idNumber,
    BuildContext context,
    String docId,
  ) async {
    _checkConnectivity(context);
    DateTime date = DateTime.now();
    CollectionReference attendance = FirebaseFirestore.instance
        .collection("attendance")
        .doc(docId)
        .collection("attendancesheet");

    try {
      DocumentReference ref = await attendance.add({
        "name": name,
        "id_number": idNumber,
        "signed_at": date.toIso8601String(),
      });

      await attendance.doc(ref.id).update({
        "doc_id": ref.id,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Attendance recorded successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to record attendance")),
      );
    }
  }
}
