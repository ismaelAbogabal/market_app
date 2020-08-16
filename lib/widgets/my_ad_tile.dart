import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:market/utils/Ad.dart';
import 'package:market/utils/data.dart';

class MyAdTile extends StatelessWidget {
  final Ad ad;
  final Function() onChanged;
  final Function() onRemove;

  const MyAdTile({Key key, this.ad, this.onChanged, this.onRemove})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/ad", arguments: ad);
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: -2)],
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                          child:
                              Image.network(ad.images[0], fit: BoxFit.cover)),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(ad.title,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue)),
                              Text(ad.price?.toString() ?? "",
                                  style: TextStyle(fontSize: 24)),
                              Expanded(child: Divider()),
                              Text(formatDate(ad.date)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Container(
                            color: Colors.blue,
                            alignment: Alignment.center,
                            child: Text(languageListener.translate("Edit"),
                                style: TextStyle(color: Colors.white)),
                          ),
                          onTap: () => edit(context),
                        ),
                      ),
                      Expanded(
                        child: OutlineButton(
                          textColor: Colors.red,
                          child: Text(languageListener.translate("Delete")),
                          onPressed: delete,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void edit(BuildContext context) async {
    await Navigator.pushNamed(context, "/add", arguments: ad);
    onChanged?.call();
  }

  void delete() async {
    for (var i in ad.images) {
      try {
        var ref = await FirebaseStorage.instance.getReferenceFromUrl(i);
        await ref.delete();
      } catch (e) {}
    }
    await Firestore.instance.collection("Ads").document(ad.id).delete();
    onRemove?.call();
  }
}
