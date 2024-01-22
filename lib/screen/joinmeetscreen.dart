import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:videocall/screen/call.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:intl/intl.dart';

class joinmeetscreen extends StatefulWidget {
  const joinmeetscreen({super.key});

  @override
  State<joinmeetscreen> createState() => _joinmeetscreenState();
}

class _joinmeetscreenState extends State<joinmeetscreen> {
  TextEditingController roomkey = TextEditingController();
  String enteredkey="";
  String correctkey="";
  void submit() async {
    setState(() {
      FocusScope.of(context).unfocus();
      enteredkey = roomkey.text.toString();
correctkey=DateFormat('EEEE').format(DateTime.now());
    });
    print(correctkey);
    print(enteredkey);

    if (enteredkey == correctkey) {
      final callid = correctkey;
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      String username = userData.data()!['username'];
      String userid = user.uid;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CallPage(
              callID: callid,
              userid: userid,
              username: username,
            );
          },
        ),
      );
    }


    else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('invalid room key'),
        ),
      );
    }
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    roomkey.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("facetime"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter room key', style: TextStyle(fontSize: 25)),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(controller: roomkey,
                decoration: InputDecoration(labelText: "Room Key"),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: Size(130, 30)),
                onPressed: () {

                  submit();
                },
                child: Text('Enter', style: TextStyle(fontSize: 25)))
          ],
        ),
      ),
    );
  }
}
