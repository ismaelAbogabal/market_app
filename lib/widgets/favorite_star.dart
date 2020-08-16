import 'package:flutter/material.dart';
import 'package:market/utils/Ad.dart';
import 'package:market/utils/data.dart';

class FavoriteStar extends StatefulWidget {
  final Ad ad;
  final Color color;
  final Color activeColor;
  final double size;

  const FavoriteStar(
      {Key key,
      @required this.ad,
      this.color = Colors.white,
      this.activeColor = Colors.blue,
      this.size})
      : assert(ad != null),
        super(key: key);
  @override
  _FavoriteStarState createState() => _FavoriteStarState();
}

class _FavoriteStarState extends State<FavoriteStar> {
  @override
  Widget build(BuildContext context) {
    bool state = widget.ad.isFavorite;
    return IconButton(
      icon: Icon(
        Icons.stars,
        color: state ? widget.activeColor : widget.color,
        size: widget.size,
      ),
      onPressed: () {
        setState(() {
          FavoriteUtils.changeState(widget.ad);
        });
      },
    );
  }
}
