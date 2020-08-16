import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:market/utils/chat.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/message.dart';
import 'package:market/utils/user.dart';
import 'package:market/widgets/message_tile.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Chat chat;
  StreamSubscription messagesStream;
  List<Message> messages = [];

  @override
  void dispose() {
    messagesStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          _buildPopUp(),
        ],
        title: Text("${chat?.ad?.name}" ?? "chat"),
        bottom: PreferredSize(
            child: ListTile(
              title: Text(chat?.ad?.title ?? "go to add",
                  style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: openAd,
            ),
            preferredSize: Size.fromHeight(60)),
      ),
      body: ListView(
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        children: messages.map((e) => MessageTile(message: e)).toList(),
      ),
      bottomSheet: _buildBottom(context),
    );
  }

  void init(BuildContext context) {
    if (chat == null) {
      chat = ModalRoute.of(context).settings.arguments;
      messagesStream = chat.messages.listen((event) {
        setState(() {
          messages = event;
        });
      });
      if (chat == null) Navigator.pop(context);
    }
  }

  void openAd() {
    Navigator.pushNamed(context, "/ad", arguments: chat.ad);
  }

  var messageController = TextEditingController();
  List<Document> documents = [];
  bool upload = false;

  _buildBottom(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.black12),
        ],
        border: Border(
          top: BorderSide(color: Colors.black26),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: languageListener.translate("Message"),
                border: InputBorder.none,
              ),
            ),
          ),
          Chip(
            avatar: Chip(
              label: Text((documents?.length ?? 0).toString()),
            ),
            backgroundColor: Colors.transparent,
            label: IconButton(
              icon: Icon(Icons.attach_file, color: Colors.blue),
              onPressed: getFiles,
            ),
          ),
          upload
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: send,
                ),
        ],
      ),
    );
  }

  void send() async {
    if (upload) return;
    if (messageController.text.isEmpty) return;

    var tokens = await User.getTokens(chat.other);

    chat.sendMessage(
        Message(text: messageController.text, documents: documents), tokens);

    messageController.text = "";
  }

  _buildPopUp() {
    return PopupMenuButton<Function>(
      onSelected: (func) => func.call(),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text(languageListener.translate("Delete Chat")),
          value: deleteChat,
        ),
        PopupMenuItem(
          child: Text(languageListener.translate("Archive Chat")),
          value: archiveChat,
        ),
      ],
    );
  }

  deleteChat() async {
    bool alert = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageListener.translate("Delete")),
        content: Text(languageListener
            .translate("Are you sure you want to delete this chat")),
        actions: <Widget>[
          FlatButton(
            child: Text(languageListener.translate("cancel")),
            onPressed: () => Navigator.pop(context, false),
          ),
          OutlineButton(
            borderSide: BorderSide(color: Colors.red),
            textColor: Colors.red,
            child: Text(languageListener.translate("Delete")),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (alert != true) return;
    Firestore.instance
        .collection("users")
        .document(cUser.uid)
        .collection("chats")
        .document(chat.id)
        .delete();
    Navigator.pop(context);
  }

  archiveChat() async {
    await Firestore.instance
        .collection("users")
        .document(cUser.uid)
        .collection("chats")
        .document(chat.id)
        .updateData({"archive": !chat.archive});
    Navigator.pop(context);
  }

  void getFiles() async {
    List<File> files = await FilePicker.getMultiFile();
    if (files != null && files.length > 0) {
      setState(() {
        upload = true;
      });
      return;
    }
    var docs =
        files.map((e) => Document.fromFile(file: e, chatId: chat.id)).toList();
    for (var x in docs) await x.upload();
    setState(() {
      documents = docs;
      upload = false;
    });
  }
}
