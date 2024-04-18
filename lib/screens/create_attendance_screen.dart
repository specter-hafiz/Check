import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/password_textfield.dart';
import 'package:check/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class CreateAttendanceScreen extends StatelessWidget {
  const CreateAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          createAttendance,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.whiteText),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: Column(
            children: [
              CreateAttendanceForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAttendanceForm extends StatefulWidget {
  const CreateAttendanceForm({
    super.key,
  });

  @override
  State<CreateAttendanceForm> createState() => _CreateAttendanceFormState();
}

class _CreateAttendanceFormState extends State<CreateAttendanceForm> {
  final TextEditingController creatorNController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController attendeesNController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFieldWidget(
              username: true,
              controller: creatorNController,
              hinttext: "Enter first name",
              prefixIcon: Icons.person),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          TextFieldWidget(
              username: true,
              controller: titleController,
              hinttext: "Title of attendance",
              prefixIcon: Icons.title),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          TextFieldWidget(
              username: true,
              controller: attendeesNController,
              hinttext: "Number of attendees",
              prefixIcon: Icons.people),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          PasswordTextField(passwordcontroller: passwordController),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          AdminAttendeeButton(
            text: setAttendance,
            callback: () {
              if (_formkey.currentState!.validate()) {
                Provider.of<DBProvider>(context, listen: false).setAttendance(
                    titleController.text,
                    creatorNController.text,
                    int.parse(attendeesNController.text),
                    passwordController.text,
                    context);
              }
            },
          )
        ],
      ),
    );
  }
}
