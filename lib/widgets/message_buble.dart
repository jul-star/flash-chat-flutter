import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  MessageBuble(
      {@required this.text, @required this.sender, @required this.user});
  final text;
  final sender;
  final user;
  @override
  Widget build(BuildContext context) {
    bool isMe = sender == user;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
      child: Column(
        crossAxisAlignment: (sender == user
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start),
        children: <Widget>[
          Material(
            borderRadius: buildBorderRadius(isMe),
            child: Text(
              sender,
              style: buildTextStyleSender(isMe),
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: buildBorderRadius(isMe),
            color: Colors.lightGreenAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Text(
                text,
                style: buildTextStyleMessage(isMe),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius buildBorderRadius(bool isMe) {
    if (isMe) {
      return BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(30.0));
    } else {
      return BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(30.0));
    }
  }

  TextStyle buildTextStyleMessage(bool isMe) {
    if (isMe) {
      return TextStyle(
        color: Colors.black,
        backgroundColor: Colors.greenAccent,
        fontSize: 30,
      );
    } else {
      return TextStyle(
        color: Colors.black,
        backgroundColor: Colors.white,
        fontSize: 30,
      );
    }
  }

  TextStyle buildTextStyleSender(bool isMe) {
    if (isMe) {
      return TextStyle(
        color: Colors.blueAccent,
        backgroundColor: Colors.greenAccent,
      );
    } else {
      return TextStyle(
        color: Colors.blueAccent,
        backgroundColor: Colors.limeAccent,
      );
    }
  }
}
