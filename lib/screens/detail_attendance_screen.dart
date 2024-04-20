import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailAttendanceScreen extends StatefulWidget {
  const DetailAttendanceScreen({
    super.key,
    required this.docId,
    required this.creatorloc,
  });
  final String docId;
  final GeoPoint creatorloc;

  @override
  State<DetailAttendanceScreen> createState() => _DetailAttendanceScreenState();
}

class _DetailAttendanceScreenState extends State<DetailAttendanceScreen> {
  double _calculateDistance(GeoPoint startLocation, GeoPoint endLocation) {
    // Extract latitude and longitude from startLocation and endLocation
    double startLat = startLocation.latitude;
    double startLon = startLocation.longitude;
    double endLat = endLocation.latitude;
    double endLon = endLocation.longitude;
    // Calculate the distance between startLocation and endLocation
    const int earthRadius = 6371000; // Earth's radius in meters
    double dLat = _degreesToRadians(endLat - startLat);
    double dLon = _degreesToRadians(endLon - startLon);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(startLat)) *
            cos(_degreesToRadians(endLat)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;

    final Stream<QuerySnapshot> _attendeesStream = FirebaseFirestore.instance
        .collection('attendance')
        .doc(currentUser.uid)
        .collection("attendances")
        .doc(widget.docId)
        .collection("attendancesheet")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendees"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _attendeesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No attendance recorded"),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              String formatDated = DateFormat.yMMMMd("en_US")
                  .format(DateTime.parse(data["signed_at"]));
              String timeformated =
                  DateFormat.jm().format(DateTime.parse(data["signed_at"]));

              double distance =
                  _calculateDistance(widget.creatorloc, data["location"]);
              return Card(
                child: ListTile(
                  onTap: null,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data["name"]),
                      Text(formatDated + "," + timeformated)
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data["id_number"]),
                      Text(distance.toStringAsFixed(2) + "m far"),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
