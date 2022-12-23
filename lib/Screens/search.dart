import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shuffle/mediaEngine/db.dart';

var sendIndex = ValueNotifier(-1);

class SearchSheet extends StatefulWidget {
  const SearchSheet({Key? key}) : super(key: key);

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  var index = Data.dbdt?["name"].length;
  var tempData = Data.dbdt;
  TextEditingController searchController = TextEditingController();
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
                  // controller: searchController,
                  onChanged: (value) {
                    // print(value);
                    updateList(value);
                  },
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
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: index,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(24.0),
                          ),
                          color: sendIndex.value == index
                              ? Colors.greenAccent.withOpacity(0.1)
                              : Colors.transparent,
                        ),
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          splashColor: Colors.white.withOpacity(0.5),
                          onTap: () {
                            if (sendIndex.value == index) {
                              setState(() {
                                sendIndex.value = -1;
                              });
                            } else {
                              setState(() {
                                sendIndex.value = index;
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
                                        Data.dbdt?["image"][index]),
                                  ),
                                ),

                                //hotstar["url"][index]
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      Data.dbdt?["name"][index],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // print(hotstar["name"].length);
                                    setState(() {
                                      Data.dbdt?["fav"][index] =
                                          !Data.dbdt?["fav"][index];
                                    });
                                  },
                                  color: Data.dbdt?["fav"][index]
                                      ? Colors.red
                                      : null,
                                  icon: Data.dbdt?["fav"][index]
                                      ? const Icon(Icons.favorite)
                                      : const Icon(
                                          Icons.favorite_border,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateList(String searchString) {
        //temp data always has the original data

        //depending on the search string, we will filter the data
        //and update the list
  
  }
}
