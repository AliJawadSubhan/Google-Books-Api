import 'dart:convert';

import 'package:complexjson/model/book_respose.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BookResponse? bookResponse;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _getBooksPlease() async {
    var url =
        Uri.parse("https://www.googleapis.com/books/v1/volumes?q=flutter");
    var response = await http.get(url);
    var decoded = jsonDecode(response.body) as Map<String, dynamic>;
    try {
      setState(() {
        bookResponse = BookResponse.fromJson(decoded);
        isLoading = true;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: C,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Complex Api :p"),
      ),
      body: ListView.builder(
        itemCount: bookResponse?.items?.length ?? 2,
        itemBuilder: (context, idx) => ListTile(
          leading: Image.network(
              'http://books.google.com/books/content?id=GmTtDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),

          // NetworkImage("http://books.google.com/books/content?id=GmTtDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"),
          title: const Text('Boook Namee'),
          subtitle: const Text("Author Name"),
        ),
      ),
    );
  }
}
