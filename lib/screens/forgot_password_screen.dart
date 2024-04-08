import 'package:check/components/colors.dart';
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
        title: const Text("Forgot Password Screen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: Column(
            children: [
              Container(
                height: SizeConfig.screenHeight! * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 7)],
                    color: AppColors.whiteText,
                    borderRadius: BorderRadius.circular(24)),
                child: Image(
                    image: AssetImage("assets/images/forgot_password.jpg")),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
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
