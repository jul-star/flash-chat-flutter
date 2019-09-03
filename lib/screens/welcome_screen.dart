import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

  final Map<String, WidgetBuilder> routes = {
    ChatScreen.id: (context) => ChatScreen(),
    LoginScreen.id: (context) => LoginScreen(),
    RegistrationScreen.id: (context) => RegistrationScreen(),
    id: (context) => WelcomeScreen(),
  };
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation color;

  @override
  void initState() {
    super.initState();
    print('----------Welcome screen ---------------');
    controller = AnimationController(
      duration: Duration(
        seconds: 5,
      ),
      vsync: this,
      upperBound: 1.0,
      lowerBound: 0.0,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addStatusListener((status) {
      print('Status: $status');
    });
    controller.addListener(() {
      setState(() {});
//      print(controller.value);
      print(animation.value);
    });
    color =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Welcome page build');
    return Scaffold(
      backgroundColor: color.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value * 100,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash'],
                  textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
//                Text(
//                  animation.value.toStringAsPrecision(2),
//                  style: TextStyle(
//                    fontSize: 30.0,
//                    fontWeight: FontWeight.w900,
//                  ),
//                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              onPressed: gotoLogin,
              color: Colors.lightBlueAccent,
            ),
            RoundedButton(
                title: 'Register',
                onPressed: gotoRegistration,
                color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  void gotoLogin() {
    gotoPage(LoginScreen.id);
  }

  void gotoRegistration() {
    gotoPage(RegistrationScreen.id);
  }

  void gotoPage(String toPage) {
    Navigator.pushNamed(context, toPage);
  }
}
