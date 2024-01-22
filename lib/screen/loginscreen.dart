import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final firebase = FirebaseAuth.instance;
class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var islogin = true;
  var isauthenticating = false;
  final formkey = GlobalKey<FormState>();

  String username = '';
  String enteredPassword = '';
  void submit() async {
    final isValid = formkey.currentState!.validate();

    if (!isValid) {
      return;
    }

    formkey.currentState!.save();

    try {
      if (islogin) {
        final userCredentials = await firebase.signInWithEmailAndPassword(
            email: username + '@gmail.com', password: enteredPassword);

      } else {
        final userCredentials = await firebase.createUserWithEmailAndPassword(
            email: username + '@gmail.com', password: enteredPassword);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': username,
         });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("facetime"),backgroundColor: Colors.blue,),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/imag.jpeg',
            ),
            Form(
              key: formkey,
              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      onSaved: (value) {
                        username = value!;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 4) {
                          return 'enter valid username';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter username',
                        icon: Icon(Icons.account_circle),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20),
                    child: TextFormField(

                      onSaved: (value) {
                        enteredPassword = value!;
                      },
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be 6 character long';
                        }
                        return null;
                      },
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Password',
                        icon: Icon(Icons.password),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  isauthenticating
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).primaryColor),
                          onPressed: () {
                            submit();
                          },
                          child: Text(
                            islogin ? 'Login' : 'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),),
                  isauthenticating
                      ? CircularProgressIndicator()
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              islogin = !(islogin);
                            });
                          },
                          child: Text(islogin
                              ? 'Create an account'
                              : 'I already have an account'),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
