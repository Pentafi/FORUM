import 'package:flutter/material.dart';
import 'package:frontend/constant.dart';
import 'package:frontend/responsive.dart';
import '../../components/background.dart';
import 'components/sign_up_top_image.dart';
import 'components/signup_form.dart';
import 'package:frontend/auth_provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final authProvider = AuthProvider();

    void signup(String username, String password) {
    // Call your signup API endpoint or perform any necessary actions
    // using the authProvider instance
    authProvider.signup(username, password)
      .then((_) {
        // Signup successful, navigate to the next screen or perform any necessary actions
      })
      .catchError((error) {
        // Handle signup error
      });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileSignupScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: SignUpScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: SignUpForm(),
                    ),
                    SizedBox(height: defaultPadding / 2),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
