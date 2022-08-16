import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shuffle/mediaEngine/db.dart';

var bG = ValueNotifier(true);

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            height: 450,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 6, 0, 0),
                      child: Text('Settings',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 26)),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12.0, 12.0, 0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close_outlined,
                            size: 32,
                          )),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    children: [
                      const Text(
                        "Animated Background",
                        style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                      ),
                      Expanded(child: Container()),
                      Switch(
                        activeColor: Colors.black.withOpacity(0.4),
                        value: bG.value,
                        onChanged: (value) {
                          setState(() {
                            bG.value = !bG.value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      rData();
                    },
                    icon: Icon(Icons.telegram)),
                IconButton(
                    onPressed: () {
                      rData();
                      print(Data.dbdt?["url"]);
                    },
                    icon: Icon(Icons.telegram_outlined)),
                Expanded(
                  child: Container(
                    child: Center(child: Text("In Development...")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
