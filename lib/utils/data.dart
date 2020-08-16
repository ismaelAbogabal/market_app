import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market/utils/admob_ad.dart';
import 'package:market/utils/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:market/utils/Ad.dart';
import 'package:market/utils/filter.dart';
import 'package:market/utils/language.dart';
import 'package:market/utils/location.dart';
import 'package:market/utils/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

export "./location.dart";

const countriesKey = "2d390652a24661ad4b14035b0922c454";

User cUser;
LocationListener locationListener = LocationListener();
NameListener nameListener = NameListener();
List<Ad> favorietAds = [];
List<Filter> _favorietFiltes = [];
LanguageListener languageListener = LanguageListener();

List<Filter> get favorietFiltes => _favorietFiltes.cast();
String adUrl;
SharedPreferences sharedPreferences;

initApp() async {
  cUser = await getUser();
  sharedPreferences = await SharedPreferences.getInstance();
  languageListener.init(sharedPreferences);
  Country.init(sharedPreferences);
  await FavoriteUtils.init();
  await locationListener.init(sharedPreferences);
  await nameListener.init();
  await getAdUrl();
  await AdMobAds.init();
}

getAdUrl() async {
  var data = await Firestore.instance.collection("MainAd").document("ad").get();
  adUrl = data.data["url"];
}

Future<User> getUser() async {
  var user = await FirebaseAuth.instance.currentUser();
  var uid = user?.uid;

  if (uid == null)
    return null;
  else
    return await User.fromId(uid);
}

class NameListener extends ChangeNotifier {
  String _name;

  init() async {
    _name = sharedPreferences.getString("userName");
    _name ??= cUser?.name;
  }

  save() async => sharedPreferences.setString("userName", _name);

  String get name => _name;

  set name(String name) {
    _name = name;
    notifyListeners();
    cUser?.updateName(name);
    save();
  }
}

class FavoriteUtils {
  static clearAds() {
    favorietAds.clear();
    save();
  }

  static clearFilters() {
    _favorietFiltes.clear();
    save();
  }

  static addFilter(Filter f) {
    _favorietFiltes.add(f);
    save();
  }

  static removeFilter(Filter f) {
    _favorietFiltes.remove(f);
    save();
  }

  static void changeState(Ad a) {
    if (!favorietAds.remove(a)) {
      favorietAds.add(a);
    }
    save();
  }

  static void save() async {
    try {
      var path = await getApplicationDocumentsDirectory();
      File f = File(path.path + "/ads.json");
      List x = favorietAds.map((e) => e.toMap(convartDate: true)).toList();
      f.writeAsString(jsonEncode(x));
    } catch (e) {}
    try {
      var path = await getApplicationDocumentsDirectory();
      File f = File(path.path + "/flters.json");
      List x = _favorietFiltes.map((e) => e.toMap()).toList();
      f.writeAsString(jsonEncode(x));
    } catch (e) {}
  }

  static init() async {
    try {
      var path = await getApplicationDocumentsDirectory();
      File f = File(path.path + "/ads.json");
      List x = jsonDecode(f.readAsStringSync());
      favorietAds = x.map((e) => Ad.fromMap(e)).toList();
    } catch (e) {}

    try {
      var path = await getApplicationDocumentsDirectory();
      File f = File(path.path + "/flters.json");
      List x = jsonDecode(f.readAsStringSync());
      _favorietFiltes = x.map((e) => Filter.fromMap(e)).toList();
    } catch (e) {}
  }
}

String formatDate(DateTime date) {
  if (date == null) return "";
  var now = DateTime.now();
  if (date.year == now.year && date.month == now.month) {
    if (date.day == now.day) {
      return "Today ${DateFormat.Hm().format(date)}";
    }
    if (date.day == now.day - 1) {
      return "Yesterday ${DateFormat.Hm().format(date)}";
    }
  }
  if (date.year == now.year) {
    return DateFormat.MMMEd().format(date);
  }
  return DateFormat.yMMMEd().format(date);
}
