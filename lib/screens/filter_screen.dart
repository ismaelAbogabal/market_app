import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/filter.dart';
import 'package:market/widgets/category_slector_alert.dart';
import 'package:market/widgets/triple_row.dart';

class FilterScreen extends StatefulWidget {
  final Filter filter;
  const FilterScreen({this.filter});
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Filter filter;
  void _locationChanged() {
    setState(() {
      filter.location = locationListener.location;
    });
  }

  @override
  void initState() {
    locationListener.addListener(_locationChanged);
    filter = widget.filter ?? Filter();
    super.initState();
  }

  @override
  void dispose() {
    locationListener.removeListener(_locationChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        children: <Widget>[
          buildSearchField(),
          buildLocationField(),
          if (filter.location != null) buildLocationScopeRow(),
          buildDistanceSelector(),
          buildCategorySelector(),
          buildPrice(),
          RaisedButton(
            colorBrightness: Brightness.dark,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Text(languageListener.translate("Search")),
            ),
            onPressed: () => Navigator.pop(context, filter),
          ),
        ],
      ),
    );
  }

  final distances = [0, 5, 10, 15, 30, 50, 75, 100];
  buildDistanceSelector() {
    return TripleRow(
      state: filter.distance != null,
      onRemove: () => setState(() => filter.distance = null),
      field: DropdownButton<int>(
        isExpanded: true,
        hint: Text(languageListener.translate("Distance")),
        onChanged: (i) {
          setState(() {
            filter.distance = i;
          });
        },
        value: filter.distance,
        items: distances
            .map(
              (e) => DropdownMenuItem<int>(
                child: Text("$e Km"),
                value: e,
              ),
            )
            .toList(),
      ),
    );
  }

  buildPrice() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TripleRow(
            state: filter.minPrice != null,
            field: TextField(
              keyboardType: TextInputType.number,
              controller:
                  TextEditingController(text: filter.minPrice?.toString()),
              onChanged: (x) {
                try {
                  filter.minPrice = double.parse(x);
                } catch (x) {}
              },
              decoration: InputDecoration(
                  labelText: languageListener.translate("Min Price")),
            ),
          ),
        ),
        Expanded(
          child: TripleRow(
            state: filter.maxPrice != null,
            field: TextField(
              keyboardType: TextInputType.number,
              controller:
                  TextEditingController(text: filter.maxPrice?.toString()),
              onChanged: (x) {
                try {
                  filter.maxPrice = double.parse(x);
                } catch (x) {}
              },
              decoration: InputDecoration(
                  labelText: languageListener.translate("Max Price")),
            ),
          ),
        ),
      ],
    );
  }

  buildCategorySelector() {
    return TripleRow(
      state: filter.category != null,
      onRemove: () => setState(() => filter.category = null),
      field: TextField(
        controller: TextEditingController(text: filter.category?.name),
        decoration: InputDecoration(
          labelText: languageListener.translate("Category"),
        ),
        readOnly: true,
        onTap: () async {
          var category = await showDialog(
            context: context,
            builder: (ctx) => CategorySelectorAlert(
              onSelect: (s) {
                Navigator.pop(ctx, s);
              },
            ),
          );
          if (category != null)
            setState(() {
              filter.category = category;
            });
        },
      ),
    );
  }

  Widget buildSearchField() {
    return TripleRow(
      onRemove: () => setState(() => filter.title = null),
      state: filter.title != null,
      field: TextField(
        controller: TextEditingController(text: filter.title),
        onChanged: (x) => filter.title = x,
        onSubmitted: (x) => setState(() {}),
        decoration: InputDecoration(
          labelText: languageListener.translate("Search"),
        ),
      ),
    );
  }

  Widget buildLocationField() {
    return TripleRow(
      state: locationListener.location != null,
      field: TextField(
        readOnly: true,
        onTap: () async {
          await Location.updateLocation(context);
        },
        controller: TextEditingController(
          text: filter.location?.translatedLast,
        ),
        decoration: InputDecoration(
          labelText: languageListener.translate("Location"),
          suffixIcon: Icon(Icons.keyboard_arrow_down),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(languageListener.translate("Market")),
      actions: <Widget>[
        FlatButton(
          child: Text(languageListener.translate("Clear")),
          onPressed: () {
            setState(() {
              filter.reset();
            });
          },
          colorBrightness: Brightness.dark,
        ),
      ],
    );
  }

  Widget buildLocationScopeRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: FittedBox(
            child: FlatButton.icon(
              onPressed: () => changeScope(Scope.country),
              label: Text(languageListener.translate("Country")),
              icon: Radio<Scope>(
                value: Scope.country,
                onChanged: changeScope,
                groupValue: filter.scope,
              ),
            ),
          ),
        ),
        Expanded(
          child: FittedBox(
            child: FlatButton.icon(
              onPressed: () => changeScope(Scope.region),
              label: Text(languageListener.translate("Region")),
              icon: Radio<Scope>(
                value: Scope.region,
                onChanged: changeScope,
                groupValue: filter.scope,
              ),
            ),
          ),
        ),
        Expanded(
          child: FittedBox(
            child: FlatButton.icon(
              onPressed: () => changeScope(Scope.city),
              label: Text(languageListener.translate("City")),
              icon: Radio<Scope>(
                value: Scope.city,
                onChanged: changeScope,
                groupValue: filter.scope,
              ),
            ),
          ),
        ),
      ],
    );
  }

  changeScope(Scope scope) {
    setState(() {
      filter.scope = scope;
      filter.distance = null;
    });
  }
}
