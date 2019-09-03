import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String _email;
  String _pswd;
  bool _showSpinner = false;
  @override
  void initState() {
    super.initState();
    print('----------Login screen ---------------');
  }

  @override
  Widget build(BuildContext context) {
    print('Login page build');

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 100.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: kTextFieldStyle,
                onChanged: (value) {
                  _email = value;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: kInputDecoration,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: kPasswordTextFieldStyle,
                obscureText: true,
                onChanged: (value) {
                  _pswd = value;
                },
                decoration:
                    kInputDecoration.copyWith(hintText: 'Enter your password.'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                onPressed: () async {
                  setState(() {
                    _showSpinner = true;
                  });
                  try {
                    AuthResult result = await _auth.signInWithEmailAndPassword(
                        email: _email, password: _pswd);
                    if (result.user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      _showSpinner = false;
                    });
                  } catch (e) {
                    print('Auth Error: $e');
                    print('Email: $_email');
                    print('Password: $_pswd');
                  }
                },
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
