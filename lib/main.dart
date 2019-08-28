import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'dart:core';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  final Map<String, WidgetBuilder> routes = {
    ChatScreen.id: (context) => ChatScreen(),
    LoginScreen.id: (context) => LoginScreen(),
    RegistrationScreen.id: (context) => RegistrationScreen(),
    WelcomeScreen.id: (context) => WelcomeScreen(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: 'welcome',
      routes: routes,
    );
  }
}
