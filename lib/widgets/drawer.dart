import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:market/utils/country.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/filter.dart';
import 'package:toast/toast.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            buildBackground(),
            Column(
              children: <Widget>[
                buildLogo(),
                (cUser == null)
                    ? RaisedButton(
                        color: Theme.of(context).primaryColor,
                        colorBrightness: Brightness.dark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/login");
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                        child: Text(languageListener.login),
                      )
                    : Text(
                        "${languageListener.translate("Logged in as")} ${nameListener.name ?? cUser.phoneNumber}"),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      ListTile(
                        title: Text(languageListener.translate("Main page")),
                        leading: Icon(Icons.home),
                        onTap: () => goToMain(context),
                      ),
                      ListTile(
                        leading: Icon(Icons.search),
                        title: Text(languageListener.translate("Browse Ads")),
                        onTap: () => open(
                            Filter(
                              location: locationListener.location,
                              scope: Scope.city,
                            ),
                            context),
                      ),
                      ListTile(
                        leading: Icon(Icons.chat),
                        title: Text(languageListener.translate("Chats")),
                        onTap: () => Navigator.pushNamed(context, "/chatsList"),
                      ),
                      ListTile(
                        leading: Icon(Icons.person_outline),
                        title: Text(languageListener.translate("My Ads")),
                        onTap: () {
                          if (cUser != null)
                            return goToMyAds(context);
                          else
                            Toast.show(
                                languageListener
                                    .translate("Please log in first"),
                                context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.stars),
                        title: Text(languageListener.translate("Favorites")),
                        onTap: () => openFavorite(context),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.add, color: Colors.orange, size: 30),
                        title: Text(
                          languageListener.translate("Place an Ad"),
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          if (cUser != null)
                            Navigator.popAndPushNamed(context, "/add");
                          else
                            Toast.show(
                                languageListener
                                    .translate("Please login first"),
                                context);
                        },
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "${languageListener.translate("change Country")} : ${Country.country.translatedName}",
                              style: TextStyle(color: Colors.grey),
                            ),
                            onPressed: () async {
                              await Country.updateCountry(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              languageListener.changeLanguage,
                              style: TextStyle(color: Colors.grey),
                            ),
                            onPressed: () =>
                                languageListener.updateLanguage(context),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              languageListener.setting,
                              style: TextStyle(color: Colors.grey),
                            ),
                            onPressed: () {
                              if (cUser != null)
                                Navigator.pushNamed(context, "/setting");
                              else
                                Toast.show(
                                    languageListener
                                        .translate("Please log in first"),
                                    context);
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              languageListener.aboutApp,
                              style: TextStyle(color: Colors.grey),
                            ),
                            onPressed: () {
//                              Navigator.pop(context);
                              showAboutDialog(
                                context: context,
                                applicationIcon: Image.asset(
                                  "assets/images/icon.png",
                                  height: 50,
                                  width: 50,
                                ),
                                applicationName: "Market",
                                applicationVersion: "1.0.0",
                              );
                            },
                          ),
                        ],
                      ),
                      if (cUser != null)
                        Row(
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                languageListener.translate("Logout"),
                                style: TextStyle(color: Colors.grey),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                                cUser.logout();
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 10),
      padding: EdgeInsets.all(10),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Image.asset(
        "assets/images/logo.png",
        width: 130,
      ),
    );
  }

  Padding buildBackground() {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Material(
        borderRadius: BorderRadius.vertical(top: Radius.elliptical(200, 50)),
        child: SizedBox.expand(),
      ),
    );
  }

  void goToMain(BuildContext context) {
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.popAndPushNamed(context, "/");
  }

  goToMyAds(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, "/myAds");
  }

  open(Filter filter, BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, "/listAds", arguments: filter);
  }

  openFavorite(BuildContext context) {
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.pushNamed(context, "/favorite");
  }

  void about(BuildContext context) {}
}
