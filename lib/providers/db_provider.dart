import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DBProvider extends ChangeNotifier {
  Future<void> setAttendance(
    String title,
    int number,
    String password,
    BuildContext context,
  ) async {
    User user = FirebaseAuth.instance.currentUser!;

    try {
      CollectionReference attendance =
          FirebaseFirestore.instance.collection("attendance");
      DocumentReference ref = await attendance.add({
        "user_id": user.uid,
        "title": title,
        "number": number,
        "password": password,
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
  ) async {
    User user = FirebaseAuth.instance.currentUser!;
    CollectionReference attendance = FirebaseFirestore.instance
        .collection("attendance")
        .doc(user.uid)
        .collection("attendancesheet");

    try {
      DocumentReference ref = await attendance.add({
        "name": name,
        "id_number": idNumber,
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
