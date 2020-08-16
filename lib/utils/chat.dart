import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market/utils/data.dart';

import './Ad.dart';
import 'message.dart';
import 'firebase_messaging.dart' as FBM;

class Chat {
  String id;
  String other;
  Ad ad;
  Message last;
  bool seen;
  bool archive;

  Chat({
    this.id,
    this.archive = false,
    this.ad,
    this.last,
    this.other,
    this.seen,
  });

  static Future<Chat> withUser(String other) async {
    var docs = await Firestore.instance
        .collection("users")
        .document(cUser.uid)
        .collection("chats")
        .where("other")
        .getDocuments();
    if (docs.documents.isEmpty)
      return null;
    else
      return docs.documents.map((e) => Chat.fromMap(e.data)).first;
  }

  Chat.fromMap(Map data)
      : this(
          id: data["id"],
          other: data["other"],
          ad: Ad.fromMap(data["ad"]),
          last: data["last"] != null ? Message.fromMap(data["last"]) : null,
          seen: data["seen"],
          archive: data["archive"],
        );

  Map toMap() {
    return {
      "id": id,
      "other": other,
      "ad": ad?.toMap(),
      "last": last?.toMap(),
      "lastDate": last?.date,
      'seen': seen,
      'archive': archive,
    };
  }

  Future sendMessage(Message m, Map tokens) async {
    m.id = Firestore.instance.collection("users").document().documentID;
    m.date ??= DateTime.now();
    m.senderID ??= cUser.uid;
    last = m;

    //update chat data
    await Firestore.instance
        .collection("users")
        .document(cUser.uid)
        .collection("chats")
        .document(id)
        .setData(toMap().cast());

    await Firestore.instance
        .collection("users")
        .document(other)
        .collection("chats")
        .document(id)
        .setData((toMap()
              ..["other"] = cUser.uid
              ..["seen"] = false)
            .cast());

    await Firestore.instance
        .collection("users")
        .document(cUser.uid)
        .collection("chats")
        .document(id)
        .collection("messages")
        .document(m.id)
        .setData(m.toMap().cast());

    await Firestore.instance
        .collection("users")
        .document(other)
        .collection("chats")
        .document(id)
        .collection("messages")
        .document(m.id)
        .setData(m.toMap().cast());

    //todo send message to tokens
    FBM.sendMessage(m.text, tokens.values.toList().cast<String>());
  }

  Future createChat() async {
    id = Firestore.instance.collection("users").document().documentID;
    Firestore.instance
        .collection("users")
        .document(cUser.uid)
        .collection("chats")
        .document(id)
        .setData({"ad": ad.toMap().cast(), "other": other, "archive": false});

    Firestore.instance
        .collection("users")
        .document(other)
        .collection("chats")
        .document(id)
        .setData({
      "ad": ad.toMap().cast(),
      "other": cUser.uid,
      "id": id,
      "archive": false
    });
  }

  static Stream<List<Chat>> getChats({bool archived = false}) async* {
    var stream = Firestore.instance
        .collection("users")
        .document(cUser.uid)
        .collection("chats")
        .where("archive", isEqualTo: archived)
        .orderBy("lastDate", descending: true)
        .snapshots();

    await for (var snap in stream) {
      print(snap.documents.map((e) => e.data["archive"]));
      yield snap.documents.map((e) => Chat.fromMap(e.data)).toList();
    }
  }

  Stream<List<Message>> get messages async* {
    var stream = Firestore.instance
        .collection("users")
        .document(cUser.uid)
        .collection("chats")
        .document(id)
        .collection("messages")
        .orderBy("date", descending: true)
        .snapshots();

    await for (var m in stream) {
      yield m.documents.map((e) => Message.fromMap(e.data)).toList();
    }
  }
}
