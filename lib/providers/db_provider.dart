import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:check/utilities/dialogs/error_dialog.dart';
import 'package:check/utilities/dialogs/success_dailog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DBProvider extends ChangeNotifier {
  Future<void> setAttendance(
    String title,
    String creatorName,
    String password,
    BuildContext context,
    TextEditingController titleController,
    TextEditingController passwordController,
  ) async {
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
        "is_active": true,
        "creator_name": creatorName,
        "title": title,
        // "creator_loc": creatorLocation,
        "password": password,
        "created_at": date.toIso8601String(),
      });

      // Update the attendance document with its document ID

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
      await attendance.doc(ref.id).update({
        "doc_id": ref.id,
        "password_doc_id": passwordDocRef.id,
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Attendance setting successful")),
      );
      titleController.clear();
      passwordController.clear();
    } catch (e) {
      // Show an error message if setting attendance fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to set attendance")),
      );
      print("Error setting attendance: $e");
    }
  }

  Future<void> deleteAttendance(BuildContext context, String userId,
      String docId, String passwordId) async {
    try {
      await FirebaseFirestore.instance
          .collection("attendance")
          .doc(userId)
          .collection("attendances")
          .doc(docId)
          .delete();
      await FirebaseFirestore.instance
          .collection("passwords")
          .doc(passwordId)
          .delete();
      //delete the corresponding password in the passwords table
      await showSuccessMessage(
          context, "Attendance deleted successfully", "Attendance Sheet");
    } catch (e) {
      await showErrorMessage(
          context, "Attendance deletion unsuccessful", "Attendance Sheet");
    }
  }

  Future<void> signAttendance(
    String name,
    String idNumber,
    BuildContext context,
    String userId,
    String password,
  ) async {
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
        final docRef = FirebaseFirestore.instance
            .collection("attendance")
            .doc(userId)
            .collection("attendances")
            .doc(refId);
        CollectionReference attendance = docRef.collection("attendancesheet");
        DocumentSnapshot attendanceDoc = await docRef.get();
        if (attendanceDoc.exists) {
          bool isAttendanceOpen = attendanceDoc["is_active"];
          if (!isAttendanceOpen) {
            await showErrorMessage(
              context,
              "Attendance is currently closed",
              "Attendance Sheet",
            );
            continue;
          }
          ;
        }
        try {
          bool isIdNumberUnique =
              await _isIdNumberUniqueInAttendanceSheet(attendance, idNumber);
          if (!isIdNumberUnique) {
            // If ID number already exists, show a message and skip signing
            await showErrorMessage(
              context,
              "ID number already signed attendance",
              "Attendance Sheet",
            );
            continue;
          }
          // Add a new attendance record
          DocumentReference ref = await attendance.add({
            "name": name,
            "id_number": idNumber,
            "signed_at": date.toIso8601String(),
          });

          // Update the newly added record with its document ID
          await attendance.doc(ref.id).update({
            "doc_id": ref.id,
          });

          // Show a success message
          await showErrorMessage(
            context,
            "Attendance recorded successfully",
            "Attendance Sheet",
          );
        } catch (e) {
          // Show an error message if adding the attendance fails
          await showErrorMessage(
              context, "Failed to record attendance", "Attendance Sheet");
        }
      }
    } else {
      // Show a message if no matching attendance documents are found
      await showErrorMessage(
        context,
        "Attendance sheet not found",
        "Attendance Sheet",
      );
    }
  }

  Future<void> openOrCloseDB(
      BuildContext context, DocumentReference document, bool isActive) async {
    try {
      await document.update({
        "is_active": isActive,
      });
      showSuccessMessage(
          context,
          "Attendance sheet ${isActive ? "opened" : "closed"}",
          "Attendance Sheet");
    } catch (e) {
      await showErrorMessage(
          context, "Failed to close attendance sheet", "Attendance Sheet");
    }
  }

  Future<void> exportToExcel(
      BuildContext context, DocumentReference document) async {
    try {
      // Check if permission to access storage is granted
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        // If permission is not granted, request permission from the user
        status = await Permission.storage.request();
        if (!status.isGranted) {
          // Permission is still not granted, handle this according to your app's logic
          // For example, you can show a message to the user indicating that permission is required
          return;
        }
      }

      // Prompt the user to enter the filename
      String? filename = await _showFilenameInputDialog(context);
      if (filename == null || filename.isEmpty) {
        // User canceled or entered an empty filename, exit function
        return;
      }

      QuerySnapshot snapshot =
          await document.collection('attendancesheet').get();
      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> attendeesData = [];

        snapshot.docs.forEach((doc) {
          Map<String, dynamic>? attendee = doc.data() as Map<String, dynamic>?;
          if (attendee != null) {
            attendeesData.add(attendee);
          }
        });

        // Create an Excel workbook
        Workbook workbook = Workbook();

        // Add a worksheet
        var sheet = workbook.worksheets[0];

        // Add headers
        var headers = ['Name', 'ID Number', 'Signed At', 'Location'];
        for (var i = 0; i < headers.length; i++) {
          sheet.getRangeByIndex(1, i + 1).setText(headers[i]);
        }

        // Add data
        for (var i = 0; i < attendeesData.length; i++) {
          var attendee = attendeesData[i];
          sheet.getRangeByIndex(i + 2, 1).setText(attendee['name']);
          sheet.getRangeByIndex(i + 2, 2).setText(attendee['id_number']);
          sheet.getRangeByIndex(i + 2, 3).setText(attendee['signed_at']);
          sheet
              .getRangeByIndex(i + 2, 4)
              .setText(attendee['location'].toString());
        }

        // Save Excel file
        String filePath = '/storage/emulated/0/Download/$filename.xlsx';
        sheet.autoFitColumn(1);
        sheet.autoFitColumn(2);
        sheet.autoFitColumn(3);
        final List<int> bytes = workbook.saveAsStream();
        await File(filePath).writeAsBytes(bytes);
        workbook.dispose();
        showSuccessMessage(
            context, 'Excel file created successfully!', "Success");
      } else {
        showErrorMessage(
            context, 'You cannot export an empty attendance sheet', "Error");
      }
    } catch (e) {
      print(e);
      showErrorMessage(context, 'Failed to export to Excel: $e', "Error");
    }
  }

  Future<String?> _showFilenameInputDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Filename'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter filename'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
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
}
