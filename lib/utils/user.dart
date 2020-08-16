import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_id/device_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:market/utils/data.dart';

import 'location.dart';

class User {
  final String uid;
  String phoneNumber;
  String name;

  Map tokens;

  Location location;

  User({this.uid, this.phoneNumber, this.name, this.location, Map tokens})
      : tokens = tokens ?? {};

  User.fromMap(Map data)
      : this(
          uid: data["id"],
          phoneNumber: data["number"],
          name: data["name"],
          location: data["location"] != null
              ? Location.fromMap(data["location"])
              : null,
          tokens: data["tokens"],
        );

  static Future<User> fromId(String id) async {
    var doc = await Firestore.instance.collection("users").document(id).get();
    if (doc.data == null || doc.data.isEmpty) return null;
    return User.fromMap(doc.data);
  }

  Map get toMap {
    return {
      "id": uid,
      "name": name,
      "number": phoneNumber,
      "location": location?.toMap(),
      "tokens": tokens ?? {}.cast(),
    };
  }

  static void setupUser(FirebaseUser u) async {
    cUser = await User.fromId(u.uid);
    // user is stored in firestore
    if (cUser == null) {
      cUser = User(
        uid: u.uid,
        name: u.displayName,
        phoneNumber: u.phoneNumber,
        tokens: {}.cast(),
      );
      cUser.login();
    }

    cUser.setupToken();
  }

  //when user login for the first time in device
  Future login() async {
    await Firestore.instance
        .collection("users")
        .document(cUser.uid)
        .setData(cUser.toMap.cast());
  }

  Future save() async {
    try {
      var d = await Firestore.instance.document(uid).get();
      if (d.data.isNotEmpty)
        await Firestore.instance
            .collection("users")
            .document(uid)
            .updateData(toMap.cast());
      else
        await Firestore.instance
            .collection("users")
            .document(uid)
            .setData(toMap.cast());
    } catch (e) {
      await Firestore.instance
          .collection("users")
          .document(uid)
          .setData(toMap.cast());
    }
  }

  Future updateName(String name) async {
    this.name = name;
    await save();
  }

  Future updateLocation(Location location) async {
    this.location = location;
    await save();
  }

  Future updateTokens(Map tokens) async {
    this.tokens = tokens;
    await save();
  }

  // ad a device token
  Future setupToken() async {
    String deviceId = await DeviceId.getID;
    String token = await FirebaseMessaging().getToken();

    tokens[deviceId] = token;

    save();
  }

  void removeToken() async {
    String device = await DeviceId.getID;
    tokens.remove(device);
    await save();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    removeToken();
    cUser = null;
    nameListener.name = "";
  }

  static Future<Map> getTokens(String id) async {
    var user = await User.fromId(id);
    return user?.tokens;
  }
}
