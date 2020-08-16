import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Message {
  String id, text, senderID;
  List<Document> documents;
  DateTime date;

  Message({
    this.documents,
    this.id,
    this.text,
    this.date,
    this.senderID,
  });

  Message.fromMap(Map data)
      : this(
          id: data["id"],
          text: data["text"],
          senderID: data["senderID"],
          date: data["date"] != null
              ? (data["date"] as Timestamp).toDate()
              : null,
          documents: data["documents"] != null
              ? (data["documents"] as List)
                  .map((e) => Document.fromMap(e))
                  .toList()
              : null,
        );

  Map toMap() {
    return {
      "text": text,
      "senderID": senderID,
      "date": date,
      "documents": documents?.map((e) => e.toMap().cast())?.toList(),
    };
  }
}

class Document {
  String chatId;
  String url, name;
  File file;

  Document.fromFile({this.file, this.chatId})
      : this.name = file.path.split("/").last;

  Document({this.name, this.url, this.chatId});

  Document.fromMap(Map data)
      : this(
          name: data["name"],
          url: data["url"],
          chatId: data["chatId"],
        );

  bool get isUploaded => url != null;

  Future upload() async {
    var ref = FirebaseStorage.instance.ref().child("chats/$chatId/$name");
    await ref.putFile(file).onComplete;
    url = (await ref.getDownloadURL()).toString();
  }

  Map toMap() {
    return {
      "name": name,
      "chatId": chatId,
      "url": url,
    };
  }
}
