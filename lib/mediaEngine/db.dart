import 'package:http/http.dart' as http;
import 'dart:convert';

class Data {
  static Map? dbdt;
}

Future<void> rData() async {
  String link =
      "https://stephenvaz.github.io/stephenvaz.shuffle_data.github.io/data.json";
  var res = await http.get(Uri.parse(link));
  var dt = Data();
  Map dbdt = json.decode(res.body);
  Data.dbdt = dbdt;
  // print(dbdt["name"]);
  // return dbdt;
//     dt.name = data["name"] as List;
//     print(dt.name);
}
