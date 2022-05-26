import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Product> fetchProduct() async {
  print("hello");
  final response = await http
      .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
      //https://veerarama-crud-api.herokuapp.com/products/all
      print("hello1");
      print(response.body);

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Product');
  }
}

class Product {
  final String id;
  final String title;
  final double price;
  final String description;
  final String image;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.image});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        image: json["image"],
      );
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Product> futureProduct;

  @override
  void initState() {
    super.initState();
    print("mukul");
    futureProduct = fetchProduct();
    print("error");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Product>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.description);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
