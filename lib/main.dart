import 'package:flutter/material.dart';
import 'package:shuffle/mediaEngine/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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

  void _launchUrl() async {
    final Uri _url = Uri.parse(randoMize());
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://media3.giphy.com/media/2tNvsKkc0qFdNhJmKk/giphy.gif?cid=ecf05e47xpaj513f1t4pdysy803hcntgnw1l9bu97luxebsx&rid=giphy.gif&ct=g"),
            fit: BoxFit.cover,
          ),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Row(
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
                      onPressed: () {
                        setState(() {
                          // Here we changing the icon.
                          toggle = !toggle;
                          _launchUrl();
                        });
                      }),
                  TextButton(
                    // style: TextButton.styleFrom(
                    //     splashFactory: NoSplash.splashFactory),
                    child: Text(
                      "Shuffle",
                      style: TextStyle(
                          fontSize: 64, color: Colors.black.withOpacity(0.2)),
                    ),
                    onPressed: () {
                      setState(() {
                        // Here we changing the icon.
                        toggle = !toggle;
                      });
                    },
                    clipBehavior: Clip.none,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
