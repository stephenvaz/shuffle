import 'package:flutter/material.dart';
import 'package:shuffle/Screens/search.dart';
import 'package:shuffle/mediaEngine/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool toggle = false;
  //temp

  void _launchUrl() async {
    var showUrl = hotstar["url"][sendIndex];
    final Uri _url = Uri.parse(randoMize(showUrl, sendIndex));
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
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/bg_grad.gif"),
            fit: BoxFit.cover,
          ),
        ),
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
                        onPressed: () {},
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
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: IconButton(
                          iconSize: 64,
                          icon: toggle
                              ? const Icon(Icons.shuffle_on_outlined)
                              : const Icon(
                                  Icons.shuffle_outlined,
                                ),
                          onPressed: () async {
                            if (sendIndex == null) {
                              final snackBar = SnackBar(
                                  // margin: EdgeInsets.symmetric(
                                  //     vertical: 10, horizontal: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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

                              // Find the ScaffoldMessenger in the widget tree
                              // and use it to show a SnackBar.
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            setState(() {
                              // Here we changing the icon.

                              toggle = !toggle;
                              _launchUrl();
                            });
                            await Future.delayed(const Duration(seconds: 2));
                            setState(() {
                              toggle = !toggle;
                            });
                          }),
                    ),
                    Builder(builder: (context) {
                      return TextButton(
                        // style: TextButton.styleFrom(
                        //     splashFactory: NoSplash.splashFactory),
                        child: Text(
                          "Shuffle",
                          style: TextStyle(
                            
                            fontSize: 64,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        onPressed: () {
                          _openModal(context);
                        },
                      );
                    })
                  ],
                ),
              );
            }),
          ),
        ));
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
                            color: Colors.white.withOpacity(0.3),
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
                      color: Colors.white.withOpacity(0.3), fontSize: 26)),
              const SizedBox(height: 10),
              Text("Stephen",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.3), fontSize: 26))
            ],
          ),
        ),
      ),
    );
  }
}
