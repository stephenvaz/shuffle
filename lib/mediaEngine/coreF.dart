import "dart:math";
import 'package:shuffle/mediaEngine/db.dart';

String randoMize(String url, int index) {
  final _random = Random();
  return url +
      Data.dbdt?["episodes"][index]
          [_random.nextInt(Data.dbdt?["episodes"][index].length)];
}
