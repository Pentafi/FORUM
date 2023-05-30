import 'package:flutter/material.dart';
import 'package:forum_app/screens/forum_page.dart';
import 'package:forum_app/screens/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Column(children: [
              Image.asset(
                'assets/images/PUTAHE.png',
                height: 200,
                width: 200,
              ),
            ]),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {}, child: const Text("Forget Password?"))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.brown,
              ),
              child: MaterialButton(
                onPressed: () async {
                  final String email = emailController.text;
                  final String password = passwordController.text;

                  final response = await http.post(
                    Uri.parse('http://127.0.0.1:8000/rest-auth/login/'), 
                    body: {'email': email, 'password': password},
                  );

                  if (response.statusCode == 200) {
                    // save the token
                    String token = jsonDecode(response.body)['token'];
                    // store token securely in device storage. Consider using flutter_secure_storage package.
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ForumPage()),
                    );
                  } else {
                    // Handle error here. Show an alert dialog or a toast.
                    print('Login failed with status code: ${response.statusCode}');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Login failed with status code: ${response.statusCode}'),
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: 'borsok',
                    fontSize: 25,
                    color: Color.fromARGB(190, 227, 179, 128),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 30,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignupPage()
                    ));
                  },
                  child: const Text("Register Account")
                ),
              ],
            ),
          ]),
        ),
      ),
    ));
  }
}
