import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/password_textfield.dart';
import 'package:check/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

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
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              AdminAttendeeButton(text: setAttendance)
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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFieldWidget(
              controller: titleController,
              hinttext: "Title of attendance",
              prefixIcon: Icons.title),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          TextFieldWidget(
              controller: numberController,
              hinttext: "Number of attendees",
              prefixIcon: Icons.people),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          PasswordTextField(passwordcontroller: passwordController)
        ],
      ),
    );
  }
}
