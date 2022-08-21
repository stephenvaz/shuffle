import 'package:flutter/material.dart';
import 'package:shuffle/Screens/search.dart';
import 'package:shuffle/mediaEngine/db.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:shuffle/Screens/settings.dart';
import 'dart:math';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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
            // child: const OfflineHome(),
            child: (isOnline ? const OnlineHome() : const OfflineHome()),
          );
        });
  }
}

class Suggest extends StatefulWidget {
  const Suggest({Key? key}) : super(key: key);

  @override
  State<Suggest> createState() => _SuggestState();
}

class _SuggestState extends State<Suggest> {
  TextEditingController showName = TextEditingController();
  TextEditingController showOTT = TextEditingController();
  TextEditingController showLink = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: const BorderSide(color: Colors.black)),
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.black.withOpacity(0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Suggestions",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.4)),
                  ),
                  TextFormField(
                    controller: showName,
                    decoration: InputDecoration(
                      labelText: "Name of show",
                      labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                  TextFormField(
                    controller: showOTT,
                    decoration: InputDecoration(
                      labelText: "OTT Platform",
                      labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                  TextFormField(
                    controller: showLink,
                    decoration: InputDecoration(
                      labelText: "URL",
                      labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final Email email = Email(
                        body:
                            'Name of show: ${showName.text} \n OTT Platform: ${showOTT.text} \n URL: ${showLink.text}',
                        subject: 'Show request',
                        recipients: ['vs1102@proton.me'],
                        isHTML: false,
                      );

                      await FlutterEmailSender.send(email);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnlineHome extends StatefulWidget {
  const OnlineHome({Key? key}) : super(key: key);

  @override
  State<OnlineHome> createState() => _OnlineHomeState();
}

class _OnlineHomeState extends State<OnlineHome> {
  bool toggle = false;

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

  Future<void> searchInitiate() async {
    inx = Data.dbdt?["name"].length;
    // print(inx);
    indexes = List.generate(inx, (inx) => inx);
    // print(indexes);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Builder(builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    return FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Suggest();
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
                    heroTag: null,
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.black.withOpacity(0.5),
                                content: const Text(
                                  "Please select a show",
                                  style: TextStyle(color: Colors.white),
                                ),
                                action: SnackBarAction(
                                    label: "Select",
                                    onPressed: () async {
                                      await searchInitiate();
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
                          await Future.delayed(const Duration(seconds: 2));
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
                      builder:
                          (BuildContext context, int sendIndex, Widget? child) {
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
                                      color: Colors.black.withOpacity(0.2)),
                                ),
                              ),

                              onTap: () async {
                                await searchInitiate();
                                _openModal(context);
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
    );
  }
}

class OfflineHome extends StatefulWidget {
  const OfflineHome({Key? key}) : super(key: key);

  @override
  State<OfflineHome> createState() => _OfflineHomeState();
}

class _OfflineHomeState extends State<OfflineHome> {
  var isLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.6),
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You seem offline :(",
                    style: TextStyle(
                        fontSize: 38,
                        color: Colors.white.withOpacity(0.4),
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () async {
                      isLoading.value = true;
                      await rData();
                      await Future.delayed(const Duration(seconds: 1));
                      if (isOnline) {
                        isLoading.value = false;
                        // Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const OnlineHome()),
                            ModalRoute.withName('/root'));
                      }
                      isLoading.value = false;
                    },
                    child: ValueListenableBuilder<bool>(
                        valueListenable: isLoading,
                        builder: (BuildContext context, bool isLoading,
                            Widget? child) {
                          return (isLoading)
                              ? Visibility(
                                  visible: isLoading,
                                  child: CircularProgressIndicator(
                                    color: Colors.black.withOpacity(0.4),
                                  ))
                              : const Icon(
                                  Icons.replay_outlined,
                                  size: 48,
                                );
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
