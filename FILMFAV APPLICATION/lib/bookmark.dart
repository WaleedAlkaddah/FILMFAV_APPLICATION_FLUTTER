import 'dart:convert';

import 'package:f1/details_book.dart';
import 'package:flutter/material.dart';
import 'details_popular.dart';
import 'model/popular.dart';
import 'model/storage.dart';
import 'package:http/http.dart' as http;

class book extends StatefulWidget {
  book({Key? key}) : super(key: key);

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  List<String> dataa = [];
  List<get_popular_data> popular_obj = [];
  String clicked = "";

  Get_data() async {
    dataa = await storage_shared.Get_Data();
    print(dataa);
    setState(() {});
  }

  Future Post(String queryid) async {
    try {
      print("Start Fetch Data");
      Uri url = Uri.parse(
          'https://api.themoviedb.org/3/movie/$queryid?api_key=23829d5b3c662d6f6d6d978adecfa756');
      var response = await http.get(url);
      final data = json.decode(response.body);
      print("fetchData_Search : ${data}");
      if (response.statusCode == 200) {
        print("fetchData_Search : ${data}");

        get_popular_data popular_obj1 = get_popular_data.fromJson(data);

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => details_book(
                    detail: popular_obj1,
                  )),
        );
      }
    } catch (ex) {
      print("object ${ex}");
    }
  }

  @override
  void initState() {
    super.initState();
    Get_data();
  }

  void clicke(String x) {
    setState(() {
      clicked = x;
      print(clicked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {
              storage_shared.clear_data();

              setState(() {
                Get_data();
              });
            },
            child: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: dataa.length,
          itemBuilder: (BuildContext context, int index) {
            final item = dataa[index];
            bool is_number = int.tryParse(item) != null;
            return Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: is_number ? Text(item) : null,
                    //leading: is_number ? null : Text(item),
                    onTap: () {
                      if (is_number) {
                        print("Clicked in number $item");
                        Post(item.toString());
                      }
                    },
                  ),
                ),
                Expanded(
                    child: ListTile(
                  title: is_number ? null : Text(item),
                ))
              ],
            );
          }),
    );
  }
}
