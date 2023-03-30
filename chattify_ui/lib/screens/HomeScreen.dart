import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final channel = IOWebSocketChannel.connect("ws://10.0.2.2:3000/ws");
  final formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  List<String> data = [];
  @override
  void initState() {
    super.initState();
    // streamListener();
    _fetch();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  _fetch() {
    channel.sink.add(json.encode({"username": "Rishabh", "userid":"44444"}));
    channel.stream.listen((event) {
      final body = json.decode(event);
      setState(() {
        data.add(body["content"]);
      });
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: 600,
        child: Form(
          child: Column(
            children: [
              Text(data.length > 0 ? data[data.length - 1] : "Wait"),
              TextFormField(
                controller: _textController,
              ),
              ElevatedButton(
                  onPressed: () {
                    final message = json.encode({
                      "username": "rishabh",
                      "content": _textController.text,
                    });
                    channel.sink.add(message);
                  },
                  child: const Text("Send")),
            ],
          ),
        ),
      ),
    ));
  }
}
