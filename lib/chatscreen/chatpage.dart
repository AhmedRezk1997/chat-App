import 'dart:ui';
import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

final _firestore = FirebaseFirestore.instance;
late User logineduser;

class Chatpage extends StatefulWidget {
  Chatpage({Key? key}) : super(key: key);

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final chatcontoller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? chattext;
  late XFile imagefile;
  Future _imagefromgallary(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imagefile = image!;
    });
    Navigator.pop(context);
  }

  Future _imagefromcamera(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imagefile = image!;
    });
    Navigator.pop(context);
  }

  _showoption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("choose"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text("Gallary"),
                      onTap: () {
                        _imagefromgallary(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                      onTap: () {
                        _imagefromcamera(context);
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    getuser();
  }

  void getuser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        logineduser = user;
        print(logineduser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 140, 190, 190),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 92, 165, 165),
        title: Row(
          children: [
            Image.asset(
              "images/welcome.png",
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text("chat me"),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //  chatstream();
                // getchat();
              },
              icon: Icon(Icons.close))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 140, 190, 190),
        child: Column(children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Text("Hi"),
              backgroundColor: Color.fromARGB(157, 0, 0, 0),
            ),
            accountName: Text("welcome"),
            accountEmail: Text("${logineduser.email}"),
          ),
          ListTile(
            title: Text("Home page"),
            leading: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("welcomepage");
            },
          ),
          ListTile(
            title: Text("Login "),
            leading: Icon(
              Icons.login,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("login");
            },
          ),
          ListTile(
            title: Text("Create new account"),
            leading: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("signup");
            },
          ),
          ListTile(
            title: Text("Sign out"),
            leading: Icon(
              Icons.exit_to_app_rounded,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("welcomepage");
            },
          ),
        ]),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chatsstram(),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(255, 29, 139, 190), width: 2))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TextFormField(
                  controller: chatcontoller,
                  onChanged: (value) {
                    chattext = value;
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      hintText: "Enter your message here",
                      fillColor: Color.fromARGB(115, 33, 177, 243)),
                )),
                IconButton(
                    onPressed: () {
                      _showoption(context);
                    },
                    icon: Icon(
                      Icons.image,
                      color: Color.fromARGB(115, 24, 84, 112),
                    )),
                TextButton(
                    onPressed: () {
                      chatcontoller.clear();
                      _firestore.collection("chat").add({
                        "text": chattext,
                        "sender": logineduser.email,
                        "time": FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      "Send",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}

class Chatsstram extends StatelessWidget {
  const Chatsstram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("chat").orderBy("time").snapshots(),
      builder: (context, snapshot) {
        List<Messagestyle> chatwidgets = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messagetext = message.get("text");
          final mesagesender = message.get("sender");
          final currentuser = logineduser.email;

          final chatwidget = Messagestyle(
            text: messagetext,
            sender: mesagesender,
            me: currentuser == mesagesender,
          );
          chatwidgets.add(chatwidget);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: chatwidgets,
          ),
        );
      },
    );
  }
}

class Messagestyle extends StatelessWidget {
  const Messagestyle({Key? key, this.text, this.sender, required this.me})
      : super(key: key);
  final String? text;
  final String? sender;
  final bool me;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: TextStyle(fontSize: 11),
          ),
          Material(
            borderRadius: BorderRadius.circular(30),
            color: me
                ? Color.fromARGB(255, 47, 160, 212)
                : Color.fromARGB(232, 27, 138, 241),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "$text ",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
