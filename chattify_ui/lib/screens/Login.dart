import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
 
  final formKey = GlobalKey<FormState>();
  String? email = "";
  String? password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Chattify",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Login to see what's cooking",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    Image.asset("assets/login.png"),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Email";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => {
                        setState(() {
                          password = value;
                        })
                      },
                      cursorColor: const Color(0xffee6b74),
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email, color: Color(0xFFee6b74)),
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFee7b64), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFee6b74), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: (val) => {
                        setState(() {
                          password = val;
                        })
                      },
                      obscureText: true,
                      cursorColor: const Color(0xffee6b74),
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFFee6b74),
                        ),
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFee7b64), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFee6b74), width: 2),
                        ),
                      ),
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Password must be atleast 6 characters long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30.0,
                            ),
                          ),
                          elevation: 0,
                          backgroundColor: const Color(
                            0xFFee6b74,
                          ),
                        ),
                        onPressed: () {
                          login();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text.rich(
                      TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(
                                text: "Register Here",
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushNamed("/signup");
                                  })
                          ]),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  login() {
    if (formKey.currentState!.validate()) {
      print("V");
    }
  }
}
