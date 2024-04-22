import 'package:check/config/size_config.dart';
import 'package:check/screens/reset_password_screen.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "Forgot Password",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your email below.\nA reset password link will be sent to you shortly",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
              ),
              ForgotPasswordForm(),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              AdminAttendeeButton(
                text: "Verify",
                callback: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResetPasswordScreen())),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    super.key,
  });

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        child: TextFieldWidget(
            controller: controller, hinttext: "Email", prefixIcon: Icons.mail));
  }
}
