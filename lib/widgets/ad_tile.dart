import 'package:flutter/material.dart';
import 'package:market/utils/Ad.dart';
import 'package:market/utils/data.dart';
import 'package:market/widgets/favorite_star.dart';

class AdTile extends StatelessWidget {
  final Ad ad;

  const AdTile({Key key, this.ad}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/ad", arguments: ad);
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: -2)],
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Hero(
                  tag: ad.images.first,
                  child: Image.network(ad.images[0], fit: BoxFit.cover),
                ),
                Align(
                  alignment: Alignment(.9, -.9),
                  child: FavoriteStar(ad: ad),
                ),
              ],
            )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(ad.title, style: TextStyle(fontSize: 20)),
                    Text(ad.price.toString() ?? "",
                        style: TextStyle(fontSize: 24)),
                    Expanded(child: Divider()),
                    Text(formatDate(ad.date)),
                    Text(ad.location?.translatedLast ?? "location not setted"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
