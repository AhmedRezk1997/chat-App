import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String username;
  late String password;
  bool showload = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 140, 190, 190),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 92, 165, 165),
        title: Text("Sign up page"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showload,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("images/singup.jpg"),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        username = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                          hintText: ("User Name"),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.lightBlue,
                          ),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.blue)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                          hintText: ("Email"),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.lightBlue,
                          ),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.blue)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                          hintText: ("Password"),
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.lightBlue,
                          ),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.blue)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("If You have account"),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("login");
                            },
                            child: Text(
                              "Click here",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        color: Color.fromARGB(255, 129, 158, 209),
                        // color: Color.fromARGB(255, 33, 177, 243),
                        onPressed: () async {
                          setState(() {
                            showload = true;
                          });
                          try {
                            final newuser =
                                await _auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            Navigator.of(context).pushNamed("chatpage");
                            setState(() {
                              showload = false;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text("Create Account ",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
