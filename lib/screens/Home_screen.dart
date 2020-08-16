import 'package:market/utils/country.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/filter.dart';
import 'package:market/widgets/app_bar.dart';
import 'package:market/widgets/category_selector.dart';
import 'package:flutter/material.dart';
import 'package:market/widgets/drawer.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Filter lastFilter;
  int page = 1;
  @override
  Widget build(BuildContext context) {
    if (Country.country == null) {
      Future.delayed(Duration(seconds: 2), () {
        Country.updateCountry(context);
      });
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: MyDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: page == 1
          ? FloatingActionButton.extended(
              label: Text(languageListener.translate("Place an Ad")),
              icon: Icon(Icons.add),
              onPressed: () {
                if (cUser == null) {
                  Navigator.pushNamed(context, "/login");
                  Future.delayed(Duration(seconds: 1), () {
                    Toast.show(languageListener.translate("Please login first"),
                        context);
                  });
                } else
                  Navigator.pushNamed(context, "/add");
              },
            )
          : null,
      body: Column(
        children: <Widget>[
          MyAppBar(
            onSearch: (s) => search(context, s),
          ),
          Expanded(
            child: CategorySelector(
              onSelect: (c) {
                return Navigator.pushNamed(
                  context,
                  "/listAds",
                  arguments: Filter(
                    category: c,
                    location: locationListener.location,
                    scope: Scope.city,
                  ),
                );
              },
              onChange: (i) {
                setState(() {
                  page = i;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void search(BuildContext context, String search) {
    Navigator.pushNamed(context, "/listAds", arguments: Filter(title: search));
  }
}
