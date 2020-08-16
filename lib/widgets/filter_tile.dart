import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/filter.dart';

class FilterTile extends StatelessWidget {
  final Filter filter;
  final Function onRemove;

  const FilterTile({Key key, this.filter, this.onRemove}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(spreadRadius: -3, blurRadius: 3),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (filter.title != null)
            Text("${languageListener.translate("Title")} : ${filter.title}"),
          if (filter.category != null)
            Text(
                "${languageListener.translate("Category")} : ${filter.category.name}"),
          if (filter.minPrice != null || filter.maxPrice != null)
            Text(
              "${filter.minPrice != null ? languageListener.translate("From") + "  " + filter.minPrice.toStringAsFixed(0) : ""}" +
                  "${filter.maxPrice != null ? languageListener.translate("To") + "  " + filter.maxPrice.toStringAsFixed(0) : ""}",
            ),
          if (filter.location != null)
            Text(
                "${languageListener.translate("Search")} : ${filter.location.name.last}"),
          if (filter.distance != null)
            Text(
                "${languageListener.translate("Distance")}: ${filter.distance} Km"),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton.icon(
                    colorBrightness: Brightness.dark,
                    icon: Icon(Icons.close),
                    label: Text("${languageListener.translate("Delete")}"),
                    onPressed: () {
                      FavoriteUtils.removeFilter(filter);
                      onRemove?.call();
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton.icon(
                    colorBrightness: Brightness.dark,
                    label: Text("${languageListener.translate("Show")}"),
                    icon: Icon(Icons.view_agenda),
                    onPressed: () {
                      Navigator.popAndPushNamed(
                        context,
                        "/listAds",
                        arguments: filter,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
