import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:videocall/resource/homebutton.dart';
import 'package:videocall/screen/newmeetscreen.dart';

import 'joinmeetscreen.dart';

class homescreen extends StatefulWidget {
  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("facetime"),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                homebutton(
                    title: "join meeting",
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return joinmeetscreen();
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.door_back_door_outlined, size: 40)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
