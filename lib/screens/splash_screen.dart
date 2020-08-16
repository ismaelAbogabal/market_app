import 'package:flutter/material.dart';
import 'package:market/utils/data.dart';

class SplashScreen extends StatelessWidget {
  final bool withoutInit;
  final Function() done;

  const SplashScreen({Key key, this.withoutInit = false, this.done})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (!withoutInit)
      init(context);
    else
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        child: Center(
            child: Image.asset(
          "assets/images/icon.png",
          width: 200,
        )),
      ),
    );
  }

  init(var context) async {
    await initApp();
    done();
  }
}
