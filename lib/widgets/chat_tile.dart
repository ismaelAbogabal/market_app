import "package:flutter/material.dart";

import "../utils/chat.dart";
import "../utils/data.dart";

class ChatTile extends StatelessWidget {
  final Chat chat;

  const ChatTile({Key key, this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => open(context),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black12,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  chat.last?.senderID == cUser.uid
                      ? languageListener.translate("You")
                      : chat.ad?.number ?? "",
                ),
                Text(formatDate(chat?.last?.date ?? DateTime.now()))
              ],
            ),
            Text(chat.ad.title),
            Divider(),
            Text(chat.last?.text ?? ""),
          ],
        ),
      ),
    );
  }

  void open(BuildContext context) {
    Navigator.pushNamed(context, "/chat", arguments: chat);
  }
}
