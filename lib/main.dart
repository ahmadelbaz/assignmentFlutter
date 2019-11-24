import 'package:flutter/material.dart';
import 'package:flutter_assignment/app.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.pinkAccent,
      ),
      title: 'Flutter Assignment',
      home: App(),
    ),
  );
}
