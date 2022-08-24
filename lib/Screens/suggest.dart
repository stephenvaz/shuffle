import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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
