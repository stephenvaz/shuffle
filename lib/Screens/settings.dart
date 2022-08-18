import 'package:flutter/material.dart';
import 'dart:ui';

var bG = ValueNotifier(true);

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var heart = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: const BorderSide(color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            // height: 450,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Made with",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 18)),
                    ValueListenableBuilder(
                        valueListenable: heart,
                        builder: (context, value, child) {
                          return IconButton(
                              onPressed: () {
                                heart.value = !heart.value;
                              },
                              icon: Icon(
                                  (heart.value
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded),
                                  color: Colors.red,
                                  size: 20));
                        }),
                    Text("by Stephen",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 18)),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.all(8),
                ),
                // Expanded(
                //   child: Container(
                //     child: Center(child: Text("In Development...")),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
