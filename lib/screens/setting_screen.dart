import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';
import 'package:toast/toast.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  listener() => setState(() {});

  @override
  void initState() {
    nameListener.addListener(listener);
    locationListener.addListener(listener);

    super.initState();
  }

  @override
  void dispose() {
    nameListener.removeListener(listener);
    locationListener.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(languageListener.setting)),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ListTile(
            title: Text(languageListener.changeName),
            subtitle: Text(nameListener.name ?? ""),
            onTap: () => changeName(context),
          ),
          Divider(),
          ListTile(
            title: Text(languageListener.changeLocation),
            subtitle: Text(locationListener.location?.name
                    ?.toString()
                    ?.replaceFirst("[", "")
                    ?.replaceFirst("]", "") ??
                ""),
            onTap: () => Navigator.pushNamed(context, "/getLocation"),
          ),
          Divider(),
          ListTile(
            title: Text(languageListener.changeNumber),
            subtitle: Text(cUser.phoneNumber ?? ""),
            onTap: () => Toast.show(languageListener.notImplemented, context),
          ),
        ],
      ),
    );
  }

  TextEditingController nameController = TextEditingController();
  void changeName(BuildContext context) async {
    nameController.text = nameListener.name;
    print(nameListener.name);
    String val = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(languageListener.changeName),
          content: TextField(
            controller: nameController,
            autofocus: true,
            onSubmitted: (value) => Navigator.pop(context, value),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(languageListener.cancel),
              onPressed: () => Navigator.pop(context),
            ),
            RaisedButton(
              textColor: Colors.white,
              child: Text(languageListener.submit),
              onPressed: () => Navigator.pop(context, nameController.text),
            ),
          ],
        );
      },
    );

    if (val == null) return;
    if (val.length < 4) Toast.show(languageListener.name4, context);

    nameListener.name = val;
  }
}
