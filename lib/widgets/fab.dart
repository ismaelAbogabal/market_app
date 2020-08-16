import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:market/utils/data.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/Ad.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:contacts_service/contacts_service.dart';

class FAB extends StatefulWidget {
  final Ad ad;

  const FAB({Key key, this.ad}) : super(key: key);
  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizeTransition(
              sizeFactor: _controller,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: box(child: Text(languageListener.translate("Call"))),
                  leading: FloatingActionButton(
                    heroTag: "call",
                    child: Icon(Icons.call),
                    onPressed: call,
                  ),
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _controller,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: box(
                      child:
                          Text(languageListener.translate("Send sms message"))),
                  leading: FloatingActionButton(
                    heroTag: "Send a message",
                    child: Icon(Icons.message),
                    onPressed: sms,
                  ),
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _controller,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: box(
                      child:
                          Text(languageListener.translate("Add to contacts"))),
                  leading: FloatingActionButton(
                    heroTag: "Add to My Phone numbers",
                    child: Icon(Icons.person_add),
                    onPressed: addContact,
                  ),
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _controller,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: box(
                      child: Text(languageListener.translate("Copy Number"))),
                  leading: FloatingActionButton(
                    heroTag: "Copy Number",
                    child: Icon(Icons.content_copy),
                    onPressed: copy,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: FloatingActionButton(
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 3 / 8).animate(_controller),
                    child: Icon(Icons.call),
                  ),
                  onPressed: () {
                    if (_controller.isCompleted) {
                      _controller.reverse();
                    } else {
                      _controller.forward();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget box({Widget child}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: child,
      ),
    );
  }

  void call() {
    launch("tel:${widget.ad.number}");
  }

  void sms() {
    launch("sms:${widget.ad.number}");
  }

  void addContact() async {
    try {
      await Permission.contacts.request();
      ContactsService.addContact(
        Contact(
          phones: [
            Item(
              label: widget.ad.name,
              value: widget.ad.number,
            ),
          ],
        ),
      );
    } catch (s) {}
  }

  void copy() {
    Clipboard.setData(ClipboardData(text: widget.ad.number.toString()));
  }
}
