import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  late String email;

  late String password;
  bool showload = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 140, 190, 190),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 92, 165, 165),
        title: Text("Login page"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showload,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("images/login.png"),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                          hintText: ("email"),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.lightBlue,
                          ),
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 67, 147, 212))),
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
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("If You haven't account"),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("signup");
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
                        color: Color.fromARGB(115, 33, 177, 243),
                        onPressed: () async {
                          setState(() {
                            showload = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              Navigator.of(context).pushNamed("chatpage");
                              setState(() {
                                showload = false;
                              });
                            }
                          } catch (e) {
                            print(e);
                          }
                        }

                        //{Navigator.of(context).pushNamed("homepage");},
                        ,
                        child: Text("Sign in",
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
