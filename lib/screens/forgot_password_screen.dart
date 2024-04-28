import 'package:check/components/colors.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/screens/reset_password_screen.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 15, color: AppColors.whiteText),
              ),
              ForgotPasswordForm(),
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1.5,
            ),
            TextFieldWidget(
              username: false,
              controller: controller,
              hinttext: "Email",
              prefixIcon: Icons.mail,
              readOnly: false,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1.5,
            ),
            AdminAttendeeButton(
              text: "Verify",
              callback: () {
                if (_formKey.currentState!.validate()) {
                  Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  ).sendResetPasswordLink(controller.text);
                }
              },
            )
          ],
        ));
  }
}
