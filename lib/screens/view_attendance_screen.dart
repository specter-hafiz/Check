import 'package:check/components/colors.dart';
import 'package:check/components/data.dart';
import 'package:check/config/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewAttendanceScreen extends StatefulWidget {
  const ViewAttendanceScreen({super.key});

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('attendance')
        .orderBy(
          "created_at",
          descending: true,
        )
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          title: const Text("View Attendance"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No attendance created yet"),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    onTap: () {},
                    title: Text(data["title"]),
                    subtitle: Text(data["created_at"]),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
