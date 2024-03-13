import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'list.dart';

class tasks extends StatefulWidget {
  const tasks({super.key});

  @override
  State<tasks> createState() => tasksState();
}

class tasksState extends State<tasks> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/image1.jpg"),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset(
                  'images/image.jpg',
                  width: 35,
                  height: 35,
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: Text('Add Task Please',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => list()));
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: Colors.teal,
                      style: TextStyle(color: Colors.teal),
                      controller: titleController,
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
                        labelText: 'Title',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    TextFormField(
                      cursorColor: Colors.teal,
                      style: TextStyle(color: Colors.teal),
                      controller: descriptionController,
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
                        labelText: 'Description',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.teal,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          final User? user = auth.currentUser;
                          if (user != null) {
                            String uid = user.uid;
                            var time = DateTime.now();
                            await FirebaseFirestore.instance
                                .collection('tasks')
                                .doc(uid)
                                .collection('mytasks')
                                .doc(time.toString())
                                .set({
                              'title': titleController.text,
                              'description': descriptionController.text,
                              'time': time.toString(),
                              'timestamp': time
                            });
                            Fluttertoast.showToast
                              (msg: 'Data Added',
                                backgroundColor: Colors.teal
                            );
                            print("data Stored successfully");
                            titleController.clear();
                            descriptionController.clear();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => list(),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(msg: 'User not signed in');
                          }
                        } catch (error) {
                          print('Error: $error');
                          Fluttertoast.showToast(msg: 'Failed to add data');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child: Text(
                        'Add Task',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
