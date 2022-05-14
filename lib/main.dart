import 'package:flutter/material.dart';
import 'package:shuffle/Screens/search.dart';
import 'package:shuffle/mediaEngine/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

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
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndTop,
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
                      onPressed: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => const FractionallySizedBox(
                              heightFactor: 0.945, child: SearchSheet()),
                        );
                        setState(() {});
                      },
                    );
                  })
                ],
              ),
            ),
          ),
        ));
  }
}
