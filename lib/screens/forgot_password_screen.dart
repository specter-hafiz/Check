import 'package:check/components/colors.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/back_button.dart';
import 'package:check/widgets/mycircular_progress_indicator.dart';
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
        leading: Backbutton(),
        title: Text(
          "Forgot Password",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.whiteText),
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(gradient: linearGradient),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal! * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your email below.\nA reset password link will be sent to you shortly",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                      ),
                ),
                ForgotPasswordForm(),
              ],
            ),
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
  bool isloading = false;
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
              onfieldSubmitted: (_) {
                _ActionMethod(context);
              },
              username: false,
              controller: controller,
              hinttext: "Email",
              prefixIcon: Icons.mail,
              readOnly: false,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1.5,
            ),
            isloading
                ? Center(
                    child: MyCircularProgressIndicator(
                      color: AppColors.blueText,
                    ),
                  )
                : AdminAttendeeButton(
                    text: "Verify",
                    callback: () {
                      _ActionMethod(context);
                    },
                  )
          ],
        ));
  }

  void _ActionMethod(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      Provider.of<AuthenticationProvider>(
        context,
        listen: false,
      ).sendResetPasswordLink(context, controller.text, controller).then((_) {
        setState(() {
          isloading = false;
        });
      }).catchError((_) {
        setState(() {
          isloading = false;
        });
      });
    }
  }
}
