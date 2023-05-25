import 'package:flutter/material.dart';
import 'package:frontend/responsive.dart';
import '../../components/background.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';
import 'package:frontend/auth_provider.dart';
import 'package:frontend/Screens/forum_list_screen.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static AuthProvider authProvider = AuthProvider();

  void login(String username, String password, BuildContext context) {
    authProvider.login(username, password)
      .then((_) {
        // Login successful, navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ForumListScreen(),
          ),
        );
      })
      .catchError((error) {
        // Handle login error
        // This is where you can show a message to the user that login failed
      });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLoginScreen(login: login),
          desktop: Row(
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginForm(
                        onLoginButtonPressed: (username, password) {
                          login(username, password, context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  final void Function(String username, String password, BuildContext context) login;

  const MobileLoginScreen({
    Key? key,
    required this.login,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(
                onLoginButtonPressed: (username, password) {
                  login(username, password, context);
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
