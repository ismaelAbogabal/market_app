import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:market/screens/Home_screen.dart';
import 'package:market/screens/ad_screen.dart';
import 'package:market/screens/add_ad_screen.dart';
import 'package:flutter/material.dart';
import 'package:market/screens/setting_screen.dart';
import 'package:market/utils/data.dart';

import './screens/ads_liast_screen.dart';
import './screens/chat/chat_screen.dart';
import './screens/chat/chats_list_screen.dart';
import './screens/favorite_screen.dart';
import './screens/login_screen.dart';
import './screens/my_ads_screen.dart';
import './screens/splash_screen.dart';
import './screens/filter_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading = true;
  @override
  initState() {
    FirebaseMessaging().configure(
      onLaunch: (message) async {
        print(message);
      },
      onMessage: (message) async {
        print(message);
      },
      onResume: (message) async {
        print(message);
      },
    );
    if (cUser != null) {
      cUser.setupToken();
    }

    languageListener.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    while (Navigator.canPop(context)) Navigator.pop(context);
    test();
    if (loading)
      return SplashScreen(done: () {
        setState(() {
          loading = false;
        });
      });
    else
      return MaterialApp(
        title: "Application",
        theme: ThemeData(
          accentColor: Colors.orangeAccent,
          buttonColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en"),
          const Locale("ar"),
        ],
        locale: languageListener.isEnglish
            ? const Locale("en")
            : const Locale("ar"),
        routes: {
          "/": (context) => HomeScreen(),
          "/add": (context) => AddAdScreen(),
          "/ad": (context) => AdScreen(),
          "/login": (context) => LoginScreen(),
          "/listAds": (context) => ListAdsScreen(),
          "/filter": (context) => FilterScreen(),
          "/favorite": (context) => FavoriteScreen(),
          "/myAds": (context) => MyAdsScreen(),
          "/chatsList": (ctx) => ChatsListScreen(),
          "/chat": (ctx) => ChatScreen(),
          "/setting": (ctx) => SettingScreen(),
        },
      );
  }

  test() {}
}

Future onMessage(Map<String, dynamic> message) async {}
