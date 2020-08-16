import 'package:flutter/material.dart';
import 'package:market/utils/Ad.dart';
import 'package:market/utils/data.dart';
import 'package:market/widgets/my_ad_tile.dart';

class MyAdsScreen extends StatefulWidget {
  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  List<Ad> ads;
  bool gettingAds = true;

  @override
  void initState() {
    print(cUser.uid);
    Ad.getUserAds(cUser.uid).then((value) => setState(() {
          gettingAds = false;
          ads = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(languageListener.translate("My Ads"))),
      body: gettingAds
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ads == null
              ? Center(
                  child: Text(
                      languageListener.translate("No Ads in this section")))
              : ListView(
                  children: ads
                      .map((e) => MyAdTile(
                            ad: e,
                            onChanged: () => setState(() {}),
                            onRemove: () => setState(() {
                              ads.remove(e);
                            }),
                          ))
                      .toList(),
                ),
    );
  }
}
