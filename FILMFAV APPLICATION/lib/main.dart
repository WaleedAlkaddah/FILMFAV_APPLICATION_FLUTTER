import 'package:f1/bookmark.dart';
import 'package:f1/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final screens = [
    home(),
    search(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.white60,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.search), label: "Search"),
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: screens[index],
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  Widget buildHeader(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 176, 23, 12),
      padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
      child: Column(
        children: const [
          CircleAvatar(
              radius: 52, backgroundImage: AssetImage('assets/image/n.jpg')),
          SizedBox(
            height: 12,
          ),
          Text(
            "",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          Text(
            "",
            style: TextStyle(fontSize: 15, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget BuildMenuItem(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.bookmark),
          title: const Text("BookMark"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => book()),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          BuildMenuItem(context),
        ],
      ),
    );
  }
}
