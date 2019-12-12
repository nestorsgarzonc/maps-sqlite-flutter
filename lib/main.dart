import 'package:flutter/material.dart';
import 'package:sqlpeoyext/src/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR scanner',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => MainPage(),
      },
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}
