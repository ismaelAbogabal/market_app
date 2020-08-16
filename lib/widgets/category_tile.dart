import 'package:market/utils/category.dart';
import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final Function() onClick;

  const CategoryTile({Key key, this.category, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: .5),
        ),
      ),
      child: ListTile(
        onTap: onClick,
        title: Text(category.translatedName),
        leading: category.hasImage
            ? AspectRatio(
                aspectRatio: 1,
                child: Image.asset(category.image),
              )
            : null,
        trailing: category.hasSons
            ? Icon(
                languageListener.isEnglish
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
              )
            : null,
      ),
    );
  }
}
