import 'package:chattify_ui/screens/HomeScreen.dart';
import 'package:chattify_ui/screens/Login.dart';
import 'package:chattify_ui/screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/login": (context) => Login(),
          "/signup": (context) => SignUp(),
          "/homescreen": (context) => HomeScreen(),
        },
        home: Scaffold(
          body: HomeScreen(),
        ));
  }
}
