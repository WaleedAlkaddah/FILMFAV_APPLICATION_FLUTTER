import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dropdown/awesome_dropdown.dart';

import 'details_popular.dart';
import 'model/popular.dart';

class search extends StatefulWidget {
  search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  final search = TextEditingController();
  List<get_popular_data> popular_obj = [];
  String selectedValue = "Language";

  Future Post(String query) async {
    print("Start Fetch Data");
    EasyLoading.show(status: 'loading...');
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=23829d5b3c662d6f6d6d978adecfa756&query=$query&language=$selectedValue&page=1');
    var response = await http.get(url);
    var data = json.decode(response.body);
    print("fetchData_Search : ${data}");
    if (response.statusCode == 200) {
      EasyLoading.showSuccess("Success");
      EasyLoading.dismiss();
      setState(() {
        popular_obj = List<get_popular_data>.from(
            data['results'].map((result) => get_popular_data.fromJson(result)));
      });
    } else {
      EasyLoading.showError("Failed");
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: search,
              onChanged: (value) {},
              onSubmitted: (value) {
                print("value ${value}");
                Post(value.toString());
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            width: 375,
            child: AwesomeDropDown(
              selectedItem: selectedValue,
              dropDownList: ['en', 'fi', 'zh', 'fr'],
              onDropDownItemClick: (selectedItem) {
                setState(() {
                  selectedValue = selectedItem;
                });
                print(selectedValue);
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 25,
                childAspectRatio: 0.6,
              ),
              itemCount: popular_obj.length,
              itemBuilder: (context, index) {
                final result = popular_obj[index];
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
                                  detail: result,
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
                              'https://image.tmdb.org/t/p/w200${result.posterPath}',
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 200,
                                  height: 200 ,
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
                            result.original_title,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
