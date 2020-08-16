import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';
import 'package:market/widgets/ad_tile.dart';
import 'package:market/widgets/drawer.dart';
import 'package:market/widgets/filter_tile.dart';
import '../utils/data.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      vsync: this,
      length: 2,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              if (tabController.index == 0) {
                FavoriteUtils.clearAds();
              } else {
                FavoriteUtils.clearFilters();
              }
              setState(() {});
            },
          )
        ],
        title: Text(languageListener.translate("Favorite")),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(text: languageListener.translate("Ads")),
            Tab(text: languageListener.translate("Searches")),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ListView(
            children: favorietAds.map((e) => AdTile(ad: e)).toList(),
          ),
          ListView(
            children: favorietFiltes
                .map((e) => FilterTile(
                      filter: e,
                      onRemove: () => setState(() {}),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
