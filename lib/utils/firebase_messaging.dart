import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';

final String serverToken = '<Server-Token>';
final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

void sendMessage(String body, List<String> tokens) async {
  List<String> token = tokens;
  final postUrl = 'https://fcm.googleapis.com/fcm/send';
  final data = {
    "to": token.first,
//    "collapse_key": "type_a",
    "notification": {
      "title": 'New message',
      "body": "$body ",
    }
  };

  final headers = {
    'content-type': 'application/json',
    'Authorization':
        "key=AAAAAjRU-40:APA91bGsi4IbUMMNj_InhoMv-TrYmqMo1tbMxY8-87CoFQDxY1BwatvS63fFyb8Nz1h7gZh9WxplZs4GM4ydKX9R9kquzFSyXRw5zTdWDzsyzyqkYQVfARkqCDItunKinv7vIQqWEEF1"
  };

  final response = await http.post(
    postUrl,
    body: json.encode(data),
    encoding: Encoding.getByName('utf-8'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print('test ok push CFM    -------------------------');
    print(response.body);
  } else {
    print(' CFM error     -------------------------');
    print(response.body);
  }
}
