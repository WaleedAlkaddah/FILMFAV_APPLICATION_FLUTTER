import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details_popular.dart';
import 'model/popular.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<get_popular_data> popular_obj = [];



  Future fetchData_Popular() async {

    print("Start fetchData_Popular");

    EasyLoading.show(status: 'loading...');
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=23829d5b3c662d6f6d6d978adecfa756');
    final response = await http.get(url);
    print(response);
    final data = json.decode(response.body);
    print("fetchData_Popular : ${data}");

    if (response.statusCode == 200) {
      EasyLoading.showSuccess("Success");
      setState(() {
        popular_obj = List<get_popular_data>.from(
          data['results'].map((result) => get_popular_data.fromJson(result)),
        );
      });
      EasyLoading.dismiss();
    } else {
      EasyLoading.showError("Failed");
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData_Popular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
          
            const Padding(
              padding: EdgeInsets.only(right: 275),
              child: Text(
                "Popular",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 620,
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 20, bottom: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 25,
                      childAspectRatio: 0.6),
                  itemCount: popular_obj.length,
                  itemBuilder: (BuildContext contex, int index) {
                    final g_data = popular_obj[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => details_popular(
                                      detail: g_data,
                                    )),
                          );
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 250,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w200${g_data.posterPath}',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                        width: 200,
                                        height: 200,
                                        child: const Text(
                                          'Failed to load image from Server',
                                          style: TextStyle(color: Colors.black),
                                        ));
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                g_data.original_title,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),

            /* 
              Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.horizontal(right: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(0, -4),
                          blurRadius: 8,
                          spreadRadius: 10)
                    ]),
              
                child: SizedBox(
                  height: 375,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemCount:
                        popular_obj.length, // Replace with your [actual item count
                    itemBuilder: (context, index) {
                      final g_data = popular_obj[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => details_popular(
                                      detail: g_data,
                                    )),
                          );
                          
                        },
                        child: Container(
                          width: 150,
                          margin: const EdgeInsets.all(
                              8.0), // Adjust the width as per your requirement
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w200${g_data.posterPath}',
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                g_data.original_title,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic),
                              ),
                             
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),*/
          ],
        ),
      ),
    );
  }
}
