import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'log.dart';

class reg extends StatefulWidget {
  const reg({Key? key}) : super(key: key);
  @override
  State<reg> createState() => regState();
}

class regState extends State<reg> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _isHidden2 = true;
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text(
              'Register Yourself!',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios, color: Colors.teal),
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
                          controller: emailController,
                          validator: (value) {
                            RegExp regex = RegExp(
                                r'(?=.*[a-z])[0-9._%+-]+@(gmail|outlook|yahoo)\.com$');
                            if (value == null || value.isEmpty) {
                              return 'Please Enter an email address';
                            }
                            if (!regex.hasMatch(value)) {
                              return 'Please enter a valid Email';
                            }
                            return null;
                          },
                          cursorColor: Colors.teal,
                          style: TextStyle(
                            color: Colors.teal,
                          ),
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
                                backgroundColor: Colors.white),
                            labelText: 'Email',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.teal,
                            ),
                            hintText: 'Enter Your Email',
                            prefixIcon:
                            Icon(Icons.email, color: Colors.teal, size: 20),
                          ),
                        ),

                        SizedBox(height: 5),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value == null || value.isEmpty) {
                              return 'Please Enter The Password';
                            }
                            if (!regex.hasMatch(value)) {
                              return 'Password should contain 1 upper case, 1 lower case, 1 digit, 1 special character, and have a length of at least 8';
                            }
                            return null;
                          },
                          cursorColor: Colors.teal,
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.teal,
                                backgroundColor: Colors.white),
                            labelText: 'Password',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.teal,
                            ),
                            hintText: 'Enter Password',
                            prefixIcon:
                            Icon(Icons.lock, color: Colors.teal, size: 20),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  _isHidden = !_isHidden;
                                });
                              },
                              child: Icon(
                                _isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.teal,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the password';
                            }
                            if (value != passwordController.text) {
                              return 'Confirmation password does not match the entered password';
                            }
                            return null;
                          },
                          obscureText: _isHidden2,
                          cursorColor: Colors.teal,
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.teal,
                                backgroundColor: Colors.white),
                            labelText: 'Confirm Password',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.teal,
                            ),
                            hintText: 'Enter Confirm Password',
                            prefixIcon: const Icon(Icons.lock,
                                color: Colors.teal, size: 20),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  _isHidden2 = !_isHidden2;
                                });
                              },
                              child: Icon(
                                _isHidden2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.teal,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                String uid = userCredential.user!.uid;
                                print("User signed up successfully with UID: $uid");
                                String? imageUrl;
                                await FirebaseFirestore.instance.collection("profile").doc(uid).set({
                                  'email': emailController.text,
                                  'pass': passwordController.text,
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Welcome ${nameController.text}',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      content: Text(
                                        'You are registered now',
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
                                                builder: (context) => log(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'OK',
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
                                // Show error dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Oops!',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      content: Text(
                                        'Error Found: $error',
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
                                                builder: (context) => reg(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Try again',
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
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already Have An Account?",
                                style: TextStyle
                                  (fontSize: 13,fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => log(),
                                  ),
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
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
}
