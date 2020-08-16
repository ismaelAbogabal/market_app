import 'package:flutter/material.dart';
import 'package:market/utils/Ad.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/filter.dart';
import 'package:market/widgets/ad_tile.dart';
import 'package:market/widgets/app_bar.dart';
import '../widgets/modify_bar.dart';

class ListAdsScreen extends StatefulWidget {
  @override
  _ListAdsScreenState createState() => _ListAdsScreenState();
}

class _ListAdsScreenState extends State<ListAdsScreen> {
  String search = "";
  List<Ad> ads = [];
  Filter filter;
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    if (filter == null) {
      filter = ModalRoute.of(context).settings.arguments;
      Ad.getAds(filter).then((value) => setState(() {
            ads = value;
            loading = false;
          }));
    }
    return Scaffold(
      appBar: PreferredSize(
        child: MyAppBar(
          onChange: (x) {
            setState(() {
              search = x;
            });
          },
        ),
        preferredSize: AppBar().preferredSize,
      ),
      body: Column(
        children: <Widget>[
          ModifyBar(
            filter: filter,
            onFiltered: filtered,
          ),
          loading
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : ads.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          languageListener.translate("No Ads in this section"),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView(
                        children: ads
                            .where((element) => element.title
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .map((e) => AdTile(ad: e))
                            .toList(),
                      ),
                    ),
        ],
      ),
    );
  }

  filtered(Filter p1) async {
    List<Ad> a = await Ad.getAds(p1);
    setState(() {
      filter = p1;
      ads = a;
      loading = false;
    });
  }
}
