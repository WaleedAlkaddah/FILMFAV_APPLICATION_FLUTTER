import 'package:flutter/material.dart';
import 'model/popular.dart';
import 'model/storage.dart';

class details_book extends StatefulWidget {
  get_popular_data detail;
  details_book({required this.detail});

  @override
  State<details_book> createState() => _details_bookState();
}

class _details_bookState extends State<details_book> {
  List<String> value = [];

  void addvalue(List<String> items) {
    setState(() {
      String x = DateTime.now().toString();
      value.addAll(items);
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w200${widget.detail.posterPath}"),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 10),
            child: InkWell(
              child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all()),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              onTap: () => {Navigator.pop(context)},
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, -4),
                        blurRadius: 8,
                      )
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.detail.original_title.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Popularity",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Language",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              widget.detail.popularity,
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              widget.detail.original_language,
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                       Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.detail.overview,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      
                      SizedBox(
                        height: 10,
                      ),
                      
                    
                    ]),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
