import 'package:flutter/material.dart';
import 'list.dart';
import 'reg.dart';
import 'reset.dart';
import 'package:firebase_auth/firebase_auth.dart';

class log extends StatefulWidget {
  const log({super.key});
  @override
  State<log> createState() => logState();
}

class logState extends State<log> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/home.jpg"),
              fit: BoxFit.cover),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text(
              'Login First',
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
                          cursorColor: Colors.teal,
                          style: TextStyle(
                            color: Colors.teal,
                          ),
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
                                backgroundColor: Colors.white),
                            labelText: "Email",
                            hintStyle:TextStyle(
                              fontSize: 15,
                              color: Colors.teal,
                            ),
                            hintText: "Enter Your Email",
                            prefixIcon: Icon(Icons.email,color: Colors.teal,size:20,),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Email";
                            }
                            bool emailValid = RegExp(
                                r'(?=.*[a-z])[0-9._%+-]+@(gmail|outlook|yahoo)\.com$'
                            ).hasMatch(value);
                            if (!emailValid) {
                              return "Enter Valid Email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height:5,
                        ),

                        TextFormField(
                          cursorColor: Colors.teal,
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                          obscureText: _isHidden,
                          controller: passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal, width: 2.0),
                            ),
                            enabledBorder:  OutlineInputBorder(
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
                            prefixIcon: Icon(Icons.lock,color: Colors.teal,size:20,),
                            suffix: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                !_isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,color: Colors.teal,size:20,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Password";
                            }
                            bool passwordValid = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
                            ).hasMatch(value);
                            if (!passwordValid) {
                              return "Password should contain 1 upper case, 1 lower case, 1 digit, 1 special character, minimum 8 length!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => reset(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Pasword?',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              ).then((value) {
                                print("User signed in successfully");
                                emailController.clear();
                                passwordController.clear();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Great',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      content: Text(
                                        'Successfully Logged In',
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
                                              MaterialPageRoute(builder: (context) => list()),
                                            );
                                          },
                                          child: Text(
                                            'Go',
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
                              }).catchError((error) {
                                print("Error signing in: $error");
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
                                        'Email address is not registered.Please try with the registered one.',
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
                                              MaterialPageRoute(builder: (context) => log()),
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
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                          ),
                          child: Text(
                            'Sign In',
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
                            Text("Don't Have any account?",
                                style: TextStyle(fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
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
                                'Register',
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
