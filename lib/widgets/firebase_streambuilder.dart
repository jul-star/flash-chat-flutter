import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/widgets/message_buble.dart';

class FirebaseStreamBuilder extends StatelessWidget {
  const FirebaseStreamBuilder({
    Key key,
    @required Firestore store,
    @required String user,
  })  : _store = store,
        _user = user,
        super(key: key);

  final Firestore _store;
  final String _user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.collection('messages').snapshots(),
      builder: (context, shapshot) {
        if (shapshot.hasData) {
          final messages = shapshot.data.documents;
          messages.sort((a, b) {
            if (a != null &&
                b != null &&
                a.data['utc'] != null &&
                b.data['utc'] != null) {
              DateTime vA = DateTime.parse(a.data['utc']);
              DateTime vB = DateTime.parse(b.data['utc']);
              return vA.difference(vB).inMilliseconds;
            } else {
              return 1;
            }
          });
          List<Widget> MessagesSet = [];
          for (var message in messages) {
            final text = message.data['text'];
            final sender = message.data['sender'];
            if (text != null && sender != null) {
              MessagesSet.add(MessageBuble(
                text: text,
                sender: sender,
                user: _user,
              ));
            }
          }
          List<Widget> ResultSet = [];
          for (int i = MessagesSet.length - 5; i < MessagesSet.length; ++i) {
            ResultSet.add(MessagesSet[i]);
          }
          return Expanded(
            child: ListView(
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: ResultSet,
            ),
          );
        } else {
          return Column(
            children: <Widget>[
              Text(
                'No messages yet',
                style: kTextFieldStyle.copyWith(backgroundColor: Colors.white),
              ),
            ],
          );
        }
      },
    );
  }
}
