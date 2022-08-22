import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shuffle/mediaEngine/db.dart';

var sendIndex = ValueNotifier(-1);
var indexes = [];
var inx = 0;

class SearchSheet extends StatefulWidget {
  const SearchSheet({Key? key}) : super(key: key);

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 10,
        sigmaY: 10,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.15),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
          ),
          child: Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.expand_more_rounded,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: TextFormField(
                  onChanged: searchTitle,
                  cursorColor: Colors.grey,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5), width: 3),
                      gapPadding: 0,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.blueGrey.withOpacity(0.8),
                      size: 26,
                    ),
                    border: const OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: inx,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, inx) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(24.0),
                            ),
                            color: sendIndex.value == indexes[inx]
                                ? Colors.greenAccent.withOpacity(0.1)
                                : Colors.transparent,
                          ),
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            splashColor: Colors.white.withOpacity(0.5),
                            onTap: () {
                              if (sendIndex.value == indexes[inx]) {
                                setState(() {
                                  sendIndex.value = -1;
                                });
                              } else {
                                setState(() {
                                  sendIndex.value = indexes[inx];
                                });

                                Navigator.pop(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image(
                                      height: 100,
                                      width: 70,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          Data.dbdt?["image"][indexes[inx]]),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        Data.dbdt?["name"][indexes[inx]] ?? "",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // print(Data.dbdt?["name"].length);
                                      setState(() {
                                        Data.dbdt?["fav"][indexes[inx]] =
                                            !Data.dbdt?["fav"][indexes[inx]];
                                      });
                                    },
                                    color:
                                        Data.dbdt?["fav"][indexes[inx]] ?? false
                                            ? Colors.red
                                            : null,
                                    icon:
                                        (Data.dbdt?["fav"][indexes[inx]] == true
                                            ? const Icon(Icons.favorite)
                                            : const Icon(
                                                Icons.favorite_border,
                                              )),
                                  ),
                                ],
                              ), //CustomListTile
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchTitle(String title) {
    var temp = [];
    final suggestions = Data.dbdt?["name"].where((element) {
      final titleDB = element.toLowerCase();
      final input = title.toLowerCase();
      return titleDB.contains(input) ? true : false;
    }).toList();
    suggestions.forEach((element) {
      temp.add(Data.dbdt?["name"].indexOf(element));
    });
    // print(indexes);
    setState(() {
      indexes = temp;
      inx = indexes.length;
    });
  }
}
