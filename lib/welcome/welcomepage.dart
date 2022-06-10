import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 140, 190, 190),
      // Color.fromRGBO(200, 227, 212, 1).withOpacity(0.5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 100,
            child: Image.asset("images/welcome.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Text(
              "Let’s chat",
              style: TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 19, 130, 204),
                  fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
            child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("login");
                },
                color: Color.fromARGB(115, 33, 177, 243),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("signup");
                },
                color: Color.fromARGB(255, 129, 158, 209),
                child: Text(
                  "sign up",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
