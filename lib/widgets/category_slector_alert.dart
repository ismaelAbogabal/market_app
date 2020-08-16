import 'package:market/utils/category.dart';
import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';

import 'category_tile.dart';

class CategorySelectorAlert extends StatefulWidget {
  final Function(Category) onSelect;
  final Function(int) onChange;

  const CategorySelectorAlert({
    Key key,
    this.onSelect,
    this.onChange,
  }) : super(key: key);
  @override
  _CategorySelectorAlertState createState() => _CategorySelectorAlertState();
}

class _CategorySelectorAlertState extends State<CategorySelectorAlert> {
  List<List<Category>> current;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    current = [Category.getAll()];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (current == null) {
      return Center(child: CircularProgressIndicator());
    } else {
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
        child: AlertDialog(
          titlePadding: EdgeInsets.all(0),
          title: AppBar(
            centerTitle: true,
            title: Text(languageListener.selectCategory,
                style: TextStyle(color: Colors.black54)),
            backgroundColor: Colors.white,
            leading:
                current.length > 1 ? BackButton(color: Colors.black) : null,
          ),
          actions: [
            FlatButton(
              child: Text(languageListener.translate("Cancel")),
              onPressed: () => Navigator.pop(context),
            )
          ],
          content: Container(
            width: 250,
            height: 400,
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              children: current.last
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
            ),
          ),
        ),
      );
    }
  }
}
