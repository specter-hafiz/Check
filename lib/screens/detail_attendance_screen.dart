import 'package:check/components/colors.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:check/widgets/detail_screen_listtile.dart';
import 'package:check/widgets/mycircular_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailAttendanceScreen extends StatefulWidget {
  const DetailAttendanceScreen({
    super.key,
    required this.docId,
    required this.active,
  });
  final String docId;
  final bool active;

  @override
  State<DetailAttendanceScreen> createState() => _DetailAttendanceScreenState();
}

class _DetailAttendanceScreenState extends State<DetailAttendanceScreen> {
  bool? switchValue;

  @override
  void initState() {
    super.initState();
    switchValue = widget.active;
    // Fetch the value from the cloud and set switchValue accordingly
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    final document = FirebaseFirestore.instance
        .collection('attendance')
        .doc(currentUser.uid)
        .collection("attendances")
        .doc(widget.docId);
    final Stream<QuerySnapshot> _attendeesStream =
        document.collection("attendancesheet").snapshots();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "Attendees",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () {
                Provider.of<DBProvider>(context, listen: false)
                    .exportToExcel(context, document);
              },
              icon: Icon(Icons.download)),
          Switch(
              activeColor: Colors.blue[900],
              trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.blue.withOpacity(0.3);
                }
                return Colors.blue[900]; // Use the default color.
              }),
              activeTrackColor: Colors.white,
              inactiveThumbColor: Colors.black,
              value: switchValue!,
              onChanged: (bool newValue) {
                setState(() {
                  switchValue = newValue;
                });
                Provider.of<DBProvider>(context, listen: false)
                    .openOrCloseDB(context, document, newValue);
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _attendeesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                "No attendance recorded",
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
              String formatDated = DateFormat.yMd("en_US")
                  .add_jm()
                  .format(DateTime.parse(data["signed_at"]));
              return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: linearGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DetailListTile(data: data, formatDated: formatDated),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
