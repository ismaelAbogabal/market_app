import 'package:flutter/material.dart';
import 'package:market/utils/country.dart';
import 'package:market/utils/data.dart';

class ChoseCountry extends StatelessWidget {
  const ChoseCountry({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Country.country != null,
      child: AlertDialog(
        title: Text(languageListener.translate("Select yor country")),
        content: Container(
          height: 200,
          width: 200,
          child: ListView(
            children: Country.countries
                .map((e) => ListTile(
                      leading: Image.asset(
                        e.flag,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        languageListener.isEnglish ? e.name : e.arabicName,
                      ),
                      onTap: () async {
                        await Country.setCountry(e);
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
          ),
        ),
        actions: <Widget>[
          if (Country.country != null)
            FlatButton(
              child: Text(languageListener.translate("Cancel")),
              onPressed: () {
                Navigator.pop(context);
              },
            )
        ],
      ),
    );
  }
}
