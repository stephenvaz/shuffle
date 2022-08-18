import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

bool isOnline = false;

class Data {
  static Map? dbdt;
}

Future<void> rData() async {
  String link =
      "https://stephenvaz.github.io/stephenvaz.shuffle_data.github.io/data.json";
  http.Response res ;
  try {
    res = await http.get(Uri.parse(link));
  } on SocketException catch (_) {
    isOnline = false;
    return;
  }
  Data.dbdt = json.decode(res.body);
  isOnline = true;
  return;
}
