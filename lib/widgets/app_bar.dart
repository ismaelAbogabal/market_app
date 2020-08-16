import 'package:market/utils/data.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  final Function(String) onSearch;
  final Function(String) onChange;
  final String title;

  const MyAppBar({
    Key key,
    this.onSearch,
    this.onChange,
    this.title,
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  bool search = false;
  final TextEditingController searchController = TextEditingController();

  listener() => setState(() {});

  @override
  void initState() {
    locationListener.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    locationListener.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (search) {
          setState(() {
            search = false;
            searchController.text = "";
          });
          return false;
        } else {
          return true;
        }
      },
      child: AppBar(
        title: _getTitle(),
        leading: search
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => setState(() => search = false),
              )
            : null,
        actions: <Widget>[
          search
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => setState(() {
                    searchController.text = "";
                  }),
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => setState(() {
                    searchController.text = "";
                    search = true;
                  }),
                ),
        ],
      ),
    );
  }

  Widget _getTitle() {
    return search
        ? TextField(
            controller: searchController,
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: widget.onChange,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            onSubmitted: (x) {
              setState(() {
                searchController.text = "";
                search = false;
                if (x.isEmpty) return;
                widget.onSearch?.call(x);
              });
            },
          )
        : GestureDetector(
            child: Text(widget.title ??
                locationListener.location?.translatedLast ??
                languageListener.translate("Chose Location")),
            onTap: () async {
              Location.updateLocation(context);
            },
          );
  }
}
