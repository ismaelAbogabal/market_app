import 'package:flutter/material.dart';
import 'package:market/utils/chat.dart';
import 'package:market/utils/data.dart';

import "dart:async";

import '../../widgets/chat_tile.dart';

class ChatsListScreen extends StatefulWidget {
  @override
  _ChatsListScreenState createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen>
    with TickerProviderStateMixin {
  TabController controller;

  List<Chat> chats = [];
  List<Chat> chatsArchived = [];

  StreamSubscription<List<Chat>> nonArcived;
  StreamSubscription<List<Chat>> arcive;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    nonArcived = Chat.getChats().listen((event) {
      setState(() {
        chats = event;
      });
    });
    arcive = Chat.getChats(archived: true).listen((event) {
      setState(() {
        chatsArchived = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    nonArcived.cancel();
    arcive.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(languageListener.translate("Chats")),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: languageListener.translate("Chats")),
            Tab(text: languageListener.translate("Archived")),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          (chats.isEmpty)
              ? Center(child: Text(languageListener.translate("No Chats Yet")))
              : ListView(
                  children: chats.map((e) {
                    return ChatTile(chat: e);
                  }).toList(),
                ),
          (chatsArchived.isEmpty)
              ? Center(
                  child: Text(languageListener.translate("No Archived Chats")))
              : ListView(
                  children: chatsArchived.map((e) {
                    return ChatTile(chat: e);
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
