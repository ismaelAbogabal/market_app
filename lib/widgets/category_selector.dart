import 'package:market/utils/category.dart';
import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';

import 'category_tile.dart';

class CategorySelector extends StatefulWidget {
  final Function(Category) onSelect;
  final Function(int) onChange;

  const CategorySelector({
    Key key,
    this.onSelect,
    this.onChange,
  }) : super(key: key);
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<List<Category>> current = [Category.getAll()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool ret = false;
        setState(() {
          if (current.length > 1) {
            current.removeLast();
            widget.onChange?.call(current.length);
          } else
            ret = true;
        });
        return ret;
      },
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        children: [
          if (current.length == 1)
            AspectRatio(
              aspectRatio: 1.6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(adUrl, fit: BoxFit.cover),
              ),
            ),
          if (current.length == 1)
            CategoryTile(
              category: Category(
                name: "Browse all",
                arabicName: "تصفح كل الاعلانات",
              ),
              onClick: () {
                widget.onSelect.call(null);
              },
            ),
          ...current.last
              .map<Widget>(
                (e) => CategoryTile(
                  category: e,
                  onClick: () {
                    if (e.hasSons)
                      setState(() {
                        current.add(e.sons);
                        widget.onChange?.call(current.length);
                      });
                    else
                      widget.onSelect?.call(e);
                  },
                ),
              )
              .toList(),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
