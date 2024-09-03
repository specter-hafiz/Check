import 'package:check/components/colors.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/screens/detail_attendance_screen.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:check/utilities/dialogs/delete_dialog.dart';
import 'package:check/widgets/mycircular_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum Options { view, delete }

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
          titleSpacing: 0,
          title: Text(
            "Attendance Sheets",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.whiteText),
          ),
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
                child: MyCircularProgressIndicator(
                  color: AppColors.blueText,
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No attendance sheets created",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                String formatedDated = DateFormat.yMd("en_US")
                    .add_jm()
                    .format(DateTime.parse(data["created_at"]));

                return Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: linearGradient,
                  ),
                  child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailAttendanceScreen(
                                  docId: data["doc_id"],
                                  active: data["is_active"],
                                )));
                      },
                      title: Text(
                        data["title"],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      subtitle: Text(
                        "Created on: " + formatedDated,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      trailing: PopupMenuButton<Options>(
                        iconColor: AppColors.whiteText,
                        onSelected: (value) async {
                          if (value == Options.delete) {
                            bool isDeleted = await deleteDialog(
                                context, "Attendance Sheet Deletion");
                            if (isDeleted) {
                              Provider.of<DBProvider>(context, listen: false)
                                  .deleteAttendance(context, data["user_id"],
                                      data["doc_id"], data["password_doc_id"]);
                            }
                          } else if (value == Options.view) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Attendance Password"),
                                      content: Text(data["password"]),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Dismiss"))
                                      ],
                                    ));
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            child: Text("Show Password"),
                            value: Options.view,
                          ),
                          const PopupMenuItem(
                            child: Text("Delete"),
                            value: Options.delete,
                          ),
                        ],
                      )),
                  // IconButton(
                  //       onPressed: () async {
                  //         bool isDeleted = await deleteDialog(
                  //             context, "Attendance Deletion");
                  //         if (isDeleted) {
                  //           Provider.of<DBProvider>(context, listen: false)
                  //               .deleteAttendance(context, data["user_id"],
                  //                   data["doc_id"], data["password_doc_id"]);
                  //         }
                  //       },
                  //       icon: Icon(
                  //         Icons.delete,
                  //         color: Colors.white,
                  //       )),
                );
              }).toList(),
            );
          },
        ));
  }
}
