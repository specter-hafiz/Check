import 'package:check/components/colors.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/screens/detail_attendance_screen.dart';
import 'package:check/utilities/dialogs/delete_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewAttendanceScreen extends StatefulWidget {
  const ViewAttendanceScreen({super.key});

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('attendance')
        .doc(currentUser.uid)
        .collection("attendances")
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
              return Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.bodyMedium,
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.blueText,
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No attendance created yet",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                String formatedDated = DateFormat.yMMMMd("en_US")
                    .format(DateTime.parse(data["created_at"]));
                String formatedTime =
                    DateFormat.jm().format(DateTime.parse(data["created_at"]));
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailAttendanceScreen(
                                docId: data["doc_id"],
                                active: data["is_active"],
                                creatorloc: data["creator_loc"],
                              )));
                    },
                    title: Text(data["title"]),
                    subtitle: Text(formatedDated + "," + formatedTime),
                    trailing: IconButton(
                        onPressed: () async {
                          bool isDeleted = await deleteDialog(
                              context, "Attendance Deletion");
                          if (isDeleted) {
                            Provider.of<DBProvider>(context, listen: false)
                                .deleteAttendance(context, data["user_id"],
                                    data["doc_id"], data["password_doc_id"]);
                          }
                        },
                        icon: Icon(Icons.delete)),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
