import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'log.dart';

class reset extends StatefulWidget {
  const reset({Key? key}) : super(key: key);

  @override
  resetState createState() => resetState();
}

class resetState extends State<reset> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/image1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text(
              'Reset Password',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => log()),
                );
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 60, right: 60, top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Image.asset(
                                'images/image.jpg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          cursorColor: Colors.teal,
                          style: TextStyle(color: Colors.teal),
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.teal,
                              backgroundColor: Colors.white,
                            ),
                            labelText: "Email",
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.teal,
                            ),
                            hintText: "Enter Your Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.teal,
                              size: 20,
                            ),
                            // ... Your InputDecoration properties ...
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                            bool emailValid = RegExp(
                                r'(?=.*[a-z])[0-9._%+-]+@(gmail|outlook|yahoo)\.com$')
                                .hasMatch(value);

                            if (!emailValid) {
                              return "Enter Valid Email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String email = emailController.text;
                              bool isEmailExists = await _checkEmailExistsInFirestore(email);
                              if (isEmailExists) {
                                try {
                                  await _auth.sendPasswordResetEmail(
                                    email: email,
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Done',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        content: Text(
                                          'Mail sent to your account',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                       log()),
                                              );
                                            },
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.teal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } catch (error) {
                                  print("Error in reset password: $error");
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Sorry!',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        content: Text(
                                          'Error Occurs',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.teal,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        log()),
                                              );
                                            },
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.teal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Error',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      content: Text(
                                        'Email address is not registered.Please try with the registered one.',
                                        style:TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      reset()),
                                            );
                                          },
                                          child: Text(
                                            'Ok',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.teal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                          ),
                          child: Text(
                            'Send Email',
                            style: TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _checkEmailExistsInFirestore(String email) async {
    try {
      var snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking email existence in Firestore: $e");
      return false;
    }
  }
}
