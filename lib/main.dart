import 'dart:convert';

import 'package:complexjson/model/book_respose.dart';
import 'package:complexjson/model/modelll.dart';
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
  BooksResponseGogle? booksResponseGogle;
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();
  String get searchKeywords => searchController.text;

  _getBooksPlease() async {
    var url = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=$searchKeywords");
    var response = await http.get(url);
    var decoded = response.body;
    var decodedData = jsonDecode(response.body);
    try {
      setState(() {
        booksResponseGogle = BooksResponseGogle.fromJson(decodedData);
        isLoading = true;
      });
    } catch (e) {
      print('This issss  $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  onSearch() => _getBooksPlease();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: C,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text("Complex Api :p"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter your search query',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[500],
                          size: 28.0,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: onSearch,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent,
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (booksResponseGogle != null && booksResponseGogle?.items != null)
              Expanded(
                child: ListView.builder(
                  itemCount: booksResponseGogle?.items?.length,
                  itemBuilder: (context, idx) => ListTile(
                    leading: Image.network(
                      booksResponseGogle!
                          .items![idx].volumeInfo!.imageLinks!.thumbnail
                          .toString(),
                    ),

                    // NetworkImage("http://books.google.com/books/content?id=GmTtDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"),
                    title: Text(booksResponseGogle!
                        .items![idx].volumeInfo!.title
                        .toString()),
                    subtitle: Text(booksResponseGogle!
                        .items![idx].volumeInfo!.authors![0]
                        .toString()),
                  ),
                ),
              ),
            if (booksResponseGogle == null)
              const Center(
                child: Text('Nullll'),
              ),
          ],
        ));
  }
}
