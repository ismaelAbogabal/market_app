import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/message.dart';
import 'package:market/widgets/message_background.dart';

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({Key key, this.message})
      : assert(message != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    bool me = message.senderID == cUser.uid;
    return Column(
      crossAxisAlignment:
          me ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(formatDate(message.date)),
        SizedBox(height: 3),
        CustomPaint(
          painter: MessageBackground(
            background: me ? Colors.green : Colors.grey[600],
            padding: 8,
            left: me,
          ),
          child: Container(
            constraints: BoxConstraints(minWidth: 100),
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              message.text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
