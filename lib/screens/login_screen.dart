import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:market/utils/data.dart';
import 'package:market/utils/user.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animation;

  PhoneNumber number;
  TextEditingController code = TextEditingController();
  String codeError;
  bool valid = false;

  String error;

  bool codeSent = false;
  String key;

  @override
  void initState() {
    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    super.initState();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animation.forward();
    return Scaffold(
      appBar: AppBar(
        title: Text(languageListener.translate("Login")),
      ),
      body: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Transform.translate(
          offset: Offset(500.0 * (animation.value - 1), 0),
          child: child,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!codeSent)
                InternationalPhoneNumberInput(
                  key: GlobalKey(),
                  formatInput: true,
                  errorMessage: error,
                  onInputChanged: (num) {
                    number = num;
                  },
                  onInputValidated: (v) {
                    valid = v;
                  },
                  initialValue: number,
                ),
              SizedBox(height: 10),
              if (!codeSent)
                FlatButton(
                  child: Text(languageListener.translate("Get My Number")),
                  onPressed: getMyNumber,
                ),
              SizedBox(height: 10),
              if (codeSent)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: TextFormField(
                    controller: code,
                    decoration: InputDecoration(
                      hintText: languageListener.translate("Code"),
                      errorText: codeError,
                    ),
                  ),
                ),
              SizedBox(height: 10),
              RaisedButton(
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(codeSent
                      ? languageListener.translate("Submit Code")
                      : languageListener.translate("Login")),
                ),
                colorBrightness: Brightness.dark,
                onPressed: codeSent ? submitCode : login,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getMyNumber() async {
    if (!codeSent) {
      try {
        var sims = await MobileNumber.getSimCards;
        if (sims.isEmpty) return;
        var num = await PhoneNumber.getRegionInfoFromPhoneNumber(
          "+${sims[0].countryPhonePrefix}${sims[0].number}",
        );
        setState(() {
          number = num;
        });
      } catch (e) {
        Toast.show(
          "Can`t get your phone",
          context,
          gravity: Toast.CENTER,
        );
      }
    }
  }

  submitCode() async {
    print("submit");
    codeError = null;
    if (codeSent && code.text.isNotEmpty) {
      var credential = PhoneAuthProvider.getCredential(
        verificationId: key,
        smsCode: code.text,
      );
      try {
        var result =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (result.user != null) {
          setupUser(result.user);
        }
      } catch (e) {
        setState(() {
          codeError = languageListener.codeError;
        });
        return;
      }
    }
  }

  void login() {
    codeError = null;

    if (valid) {
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number.phoneNumber,
        timeout: Duration(minutes: 2),
        verificationCompleted: (phoneAuthCredential) async {
          var result = await FirebaseAuth.instance
              .signInWithCredential(phoneAuthCredential);
          setupUser(result.user);
        },
        verificationFailed: (e) {
          setState(() {
            key = null;
            codeSent = false;
            error = e.message;
          });
        },
        codeSent: (verificationId, [forceResendingToken]) {
          print("code sent");
          setState(() {
            error = null;
            codeError = null;
            codeSent = true;
            valid = true;
            key = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          codeSent = false;
          key = null;
          error = languageListener.translate("Code Time out");
        },
      );
    } else {
      Toast.show(
          languageListener.translate("Please enter a valid number"), context);
    }
  }

  //when user log in
  void setupUser(FirebaseUser u) async {
    User.setupUser(u);

    nameListener.name = cUser?.name ?? nameListener.name;
    Navigator.pop(context);
  }
}
