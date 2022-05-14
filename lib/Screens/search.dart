import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shuffle/mediaEngine/data.dart';

var sendIndex;

class SearchSheet extends StatefulWidget {
  const SearchSheet({Key? key}) : super(key: key);

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  var index = hotstar["name"].length;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 10,
        sigmaY: 10,
      ),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
              child: Icon(
                Icons.expand_more_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: TextFormField(
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
                        color: sendIndex == index
                            ? Colors.greenAccent.withOpacity(0.1)
                            : Colors.transparent,
                      ),
                      child: InkWell(
                        onTap: () {
                          sendIndex = index;
                          Navigator.pop(context);
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
                                    image:
                                        NetworkImage(hotstar["image"][index])),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              //hotstar["url"][index]
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hotstar["name"][index],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              IconButton(
                                onPressed: () {
                                  // print(hotstar["name"].length);
                                  setState(() {
                                    hotstar["fav"][index] =
                                        !hotstar["fav"][index];
                                  });
                                },
                                color:
                                    hotstar["fav"][index] ? Colors.red : null,
                                icon: hotstar["fav"][index]
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
    );
  }
}
