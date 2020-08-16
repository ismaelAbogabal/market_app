import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/utils/Ad.dart';
import 'package:market/widgets/ad_tile.dart';

class UserAdsList extends StatelessWidget {
  final String userId;
  final String name;

  const UserAdsList({Key key, this.userId, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: FutureBuilder<List<Ad>>(
        future: Ad.getUserAds(userId),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Getting ads "));
          } else {
            return ListView(
              children: snapshot.data.map((e) => AdTile(ad: e)).toList(),
            );
          }
        },
      ),
    );
  }
}
