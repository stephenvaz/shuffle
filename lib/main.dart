import 'package:flutter/material.dart';
import 'package:shuffle/Screens/search.dart';
import 'package:shuffle/mediaEngine/coreF.dart';
import 'package:shuffle/mediaEngine/db.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:shuffle/Screens/settings.dart';
import 'dart:math';

//bool for background(gif/nothing)

void main() async {
  await rData();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool toggle = false;
  bool dataRetrieved = false;
  //temp

  void _launchUrl() async {
    var showUrl = Data.dbdt?["url"][sendIndex.value];
    final Uri _url = Uri.parse(randoMize(showUrl, sendIndex.value));
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }

  Future<void> _openModal(context) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          const FractionallySizedBox(heightFactor: 0.945, child: SearchSheet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return ValueListenableBuilder<bool>(
        valueListenable: bG,
        builder: (BuildContext context, bool bG, Widget? child) {
          return Container(
            decoration: BoxDecoration(
                image: (bG == true)
                    ? const DecorationImage(
                        image: AssetImage("lib/assets/bg_grad.gif"),
                        fit: BoxFit.cover,
                      )
                    : null,
                gradient: (bG == false)
                    ? const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        transform: GradientRotation(pi / 4),
                        colors: [Colors.tealAccent, Colors.blue])
                    : null),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SafeArea(
                child: Builder(builder: (context) {
                  return Scaffold(
                    floatingActionButton: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(builder: (context) {
                            return FloatingActionButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Me();
                                    });
                                // Me();
                              },
                              child: const Icon(
                                Icons.rocket_launch_outlined,
                                color: Colors.black,
                                size: 32,
                              ),
                              highlightElevation: 0,
                              backgroundColor: Colors.transparent,
                              splashColor: Colors.black,
                              elevation: 0,
                            );
                          }),
                          FloatingActionButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Settings();
                                  });
                            },
                            child: const Icon(
                              Icons.settings_outlined,
                              color: Colors.black,
                              size: 32,
                            ),
                            highlightElevation: 0,
                            backgroundColor: Colors.transparent,
                            splashColor: Colors.black,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.miniCenterTop,
                    backgroundColor: Colors.transparent,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                iconSize: 64,
                                icon: toggle
                                    ? const Icon(Icons.shuffle_on_outlined)
                                    : const Icon(
                                        Icons.shuffle_outlined,
                                      ),
                                onPressed: () async {
                                  if (sendIndex.value == -1) {
                                    final snackBar = SnackBar(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor:
                                            Colors.black.withOpacity(0.5),
                                        content: const Text(
                                          "Please select a show",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        action: SnackBarAction(
                                            label: "Select",
                                            onPressed: () {
                                              _openModal(context);
                                            }));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    return;
                                  }
                                  setState(() {
                                    toggle = !toggle;
                                    _launchUrl();
                                  });
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  setState(() {
                                    toggle = !toggle;
                                  });
                                }),
                            Center(
                              child: Transform.rotate(
                                  angle: 3.14 / 2,
                                  child: const Icon(
                                    Icons.horizontal_rule_rounded,
                                    size: 64,
                                  )),
                            ),
                            ValueListenableBuilder<int>(
                              builder: (BuildContext context, int sendIndex,
                                  Widget? child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: (sendIndex == -1)
                                        ? Colors.transparent
                                        : Colors.black.withOpacity(0.2),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      // style: TextButton.styleFrom(
                                      //     splashFactory: NoSplash.splashFactory),
                                      borderRadius: BorderRadius.circular(18),
                                      child: Center(
                                        child: Text(
                                          "Shuffle",
                                          style: TextStyle(
                                              fontSize: 58,
                                              color: Colors.black
                                                  .withOpacity(0.2)),
                                        ),
                                      ),

                                      onTap: () {
                                        _openModal(context);
                                        (dataRetrieved == false)
                                            ? rData()
                                            : null;
                                      },
                                    ),
                                  ),
                                );
                              },
                              valueListenable: sendIndex,
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          );
        });
  }
}

class Me extends StatelessWidget {
  const Me({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.black.withOpacity(0.2),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 6, 0, 0),
                    child: Text('Shuffle',
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
              Text("by",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 26)),
              const SizedBox(height: 10),
              Text("Stephen",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.4), fontSize: 26))
            ],
          ),
        ),
      ),
    );
  }
}
