import 'dart:io';
import "dart:math";
import 'package:http/http.dart' as http;
import 'dart:convert';

bool isOnline = false;


String randoMize(String url, int index) {
  final _random = Random();
  return url +
      Data.dbdt?["episodes"][index]
          [_random.nextInt(Data.dbdt?["episodes"][index].length)];
}
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
