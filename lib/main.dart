import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shuffle/Screens/search.dart';
import 'package:shuffle/mediaEngine/db.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:shuffle/Screens/settings.dart';
import 'dart:math';
import 'package:shuffle/Screens/suggest.dart';

//test variables
bool jsDB = true;
//

void main() async {
  await rData();
  WidgetsFlutterBinding.ensureInitialized();
  await getData();
  runApp(const MyApp());
}

Future<void> getData() async {
  final prefs = await SharedPreferences.getInstance();
  final bool? bGval = prefs.getBool('background');
  if (bGval == null) {
    prefs.setBool('background', true);
  } else {
    bG.value = bGval;
  }
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
            child: (isOnline ? const OnlineHome() : const OfflineHome()),
          );
        });
  }
}

class OnlineHome extends StatefulWidget {
  const OnlineHome({Key? key}) : super(key: key);

  @override
  State<OnlineHome> createState() => _OnlineHomeState();
}

class _OnlineHomeState extends State<OnlineHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Home(),
      home: ShowCaseWidget(
        builder: Builder(builder: (context) {
          return const Home();
        }),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //showcase
  final k1 = GlobalKey();
  final k2 = GlobalKey();
  final k3 = GlobalKey();
  final k4 = GlobalKey();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) => ShowCaseWidget.of(context).startShowCase([k1]),
    // );
    displayShowCase();
  }

  void displayShowCase() async {
    final prefs = await SharedPreferences.getInstance();

    bool? showCase = prefs.getBool("showCaseVal");
    // print(showCase);
    if (showCase == null) {
      // print("debug1");
      await prefs.setBool("showCaseVal", true);
    }
    if (prefs.getBool("showCaseVal") == true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ShowCaseWidget.of(context).startShowCase([k1, k2, k3, k4]);
      });
      prefs.setBool("showCaseVal", false);
    }
    // print(prefs.getBool("showCaseVal"));
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ShowCaseWidget.of(context).startShowCase([k1, k2, k3, k4]);
    // });
  }

  //data
  bool toggle = false;
  void _launchUrl() async {
    var showUrl = Data.dbdt?["url"][sendIndex.value];
    final Uri _url = Uri.parse(randoMize(showUrl, sendIndex.value));
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      // throw 'Could not launch $_url';
      // print('Could not launch $_url');
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

  Future<void> _openPage(context, Widget w) async {
    // await showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) =>
    //       const FractionallySizedBox(heightFactor: 0.945, child: Settings()),
    // );
    await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: w,
        );
      },
      transitionDuration: const Duration(milliseconds: 150),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return w;
      },
    );
  }

  // Future<void> _openSlider(context, Widget w) async{

  // }

  Future<void> searchInitiate() async {
    if (jsDB) {
      inx = Data.dbdt?["name"].length;
      indexes = List.generate(inx, (inx) => inx);
      jsDB = false;
      // print("fetched");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        return GestureDetector(
          onPanUpdate: (details) {
            // Swiping in right direction.
            if (details.delta.dx > 0) {
              _openPage(context, const Suggest());
            }

            // Swiping in left direction.
            if (details.delta.dx < 0) {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => Settings()));
              _openPage(context, const Settings());
            }
          },
          onVerticalDragUpdate: (details) async {
            await searchInitiate();

            _openModal(context);
          },
          // onHorizontalDragUpdate: (details) {
          //   if (details.delta.direction > 0) {
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (context) => Suggest()));
          //   }
          // },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    return Showcase(
                      key: k3,
                      description: "Suggest a show",
                      shapeBorder: const CircleBorder(),
                      contentPadding: const EdgeInsets.all(16),
                      //descTextStyle: TextStyle(fontSize: 18),
                      //showcaseBackgroundColor: Colors.white.withOpacity(0.6),
                      child: FloatingActionButton(
                        heroTag: null,
                        onPressed: () {
                          showGeneralDialog(
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionBuilder: (context, a1, a2, widget) {
                              return Transform.scale(
                                scale: a1.value,
                                child: const Suggest(),
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 150),
                            barrierDismissible: true,
                            barrierLabel: '',
                            context: context,
                            pageBuilder: (context, animation1, animation2) {
                              return const Suggest();
                            },
                          );
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
                      ),
                    );
                  }),
                  Showcase(
                    description: "Access Settings",
                    key: k4,
                    shapeBorder: const CircleBorder(),
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        showGeneralDialog(
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionBuilder: (context, a1, a2, widget) {
                            return Transform.scale(
                              scale: a1.value,
                              child: const Settings(),
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 150),
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (context, animation1, animation2) {
                            return const Settings();
                          },
                        );
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
                    Showcase(
                      key: k2,
                      description: "Randomize and Play",
                      shapeBorder: const CircleBorder(),
                      child: IconButton(
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
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
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
                    ),
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
                          child: Showcase(
                            key: k1,
                            description: "Click here to select a show",
                            shapeBorder: const CircleBorder(),
                            contentPadding: const EdgeInsets.all(16),
                            // disposeOnTap: true,
                            // onTargetClick: () async {
                            //   await searchInitiate();
                            //   _openModal(context);
                            // },
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
                          ),
                        );
                      },
                      valueListenable: sendIndex,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
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
                        Navigator.pushAndRemoveUntil(
                            context,
                            // MaterialPageRoute(
                            //   builder: (BuildContext context) =>
                            //       const OnlineHome(),
                            // ),
                            PageRouteBuilder(
                              pageBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                              ) =>
                                  const OnlineHome(),
                              transitionsBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child,
                              ) =>
                                  ScaleTransition(
                                scale: Tween<double>(
                                  begin: 0.0,
                                  end: 1.0,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                ),
                                child: child,
                              ),
                            ),
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
