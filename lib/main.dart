import 'package:clean_cms/Views/start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean CMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Started(),
    );
  }
}
