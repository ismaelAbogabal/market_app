import 'package:flutter/material.dart';

class ImagesScreen extends StatelessWidget {
  final List<String> images;
  final int current;

  const ImagesScreen({Key key, this.images, this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: images.first,
      child: PageView(
        controller: PageController(initialPage: current),
        children: images
            .map(
              (e) => Image.network(e, fit: BoxFit.cover),
            )
            .toList(),
      ),
    );
  }
}
