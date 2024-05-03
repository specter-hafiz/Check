import 'package:check/components/colors.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/mycircular_progress_indicator.dart';
import 'package:check/widgets/password_textfield.dart';
import 'package:check/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAttendanceForm extends StatefulWidget {
  const CreateAttendanceForm({
    super.key,
    required this.username,
  });
  final String username;

  @override
  State<CreateAttendanceForm> createState() => _CreateAttendanceFormState();
}

class _CreateAttendanceFormState extends State<CreateAttendanceForm> {
  final TextEditingController creatorNController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    creatorNController.text = widget.username;
    super.initState();
  }

  @override
  void dispose() {
    creatorNController.dispose();
    titleController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
            prefixIcon: Icons.person,
            readOnly: true,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 1,
          ),
          TextFieldWidget(
            username: true,
            controller: titleController,
            hinttext: "Title of attendance",
            prefixIcon: Icons.title,
            readOnly: false,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 1,
          ),
          PasswordTextField(
            passwordcontroller: passwordController,
            hintText: "Password to attendance",
            callback: (_) {
              _ActionMethod(context);
            },
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 1,
          ),
          isLoading
              ? MyCircularProgressIndicator(
                  color: AppColors.whiteText,
                )
              : AdminAttendeeButton(
                  text: "Create",
                  callback: () {
                    _ActionMethod(context);
                  },
                )
        ],
      ),
    );
  }

  void _ActionMethod(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Provider.of<DBProvider>(context, listen: false)
          .setAttendance(
              titleController.text,
              creatorNController.text,
              passwordController.text,
              context,
              titleController,
              passwordController)
          .then((_) {
        setState(() {
          isLoading = false;
        });
      }).catchError((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }
}
